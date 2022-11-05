require "../src/sdl"
require "../src/image"

SDL.init(SDL::Init::VIDEO | SDL::Init::HAPTIC | SDL::Init::GAMECONTROLLER); at_exit { SDL.quit }
SDL.set_hint(SDL::Hint::RENDER_SCALE_QUALITY, "1")

SDL::IMG.init(SDL::IMG::Init::PNG); at_exit { SDL::IMG.quit }

window = SDL::Window.new("SDL tutorial", 640, 480)
renderer = SDL::Renderer.new(window)
texture = SDL::IMG.load(File.join(__DIR__, "data", "haptics.png"), renderer)

# in this example, we are tracking the controllers by their instance ids and not the device's index id.
# since the SDL controller events primarilly use the device's instance id and not its index.
# see the loop below for more details.
# get all connected controllers, if any.
controllers : Hash(LibSDL::JoystickID, SDL::GameController) = (0..LibSDL.num_joysticks - 1).to_h do |idx|
  {
    SDL::GameController.instance_id(idx),
    SDL::GameController.new(idx),
  }
end

trigger_axis = {
  left:  SDL::GameController::Axis::TRIGGERLEFT.value,
  right: SDL::GameController::Axis::TRIGGERRIGHT.value,
}

loop do
  case event = SDL::Event.poll
  when SDL::Event::Quit
    break
  when SDL::Event::ControllerButton
    # when a controller button is pressed, event.which returns the device instance id, NOT the device index
    # make sure we have a valid controller
    next unless controller = controllers[event.which]?

    freq = (0xffff * 3 // 4).to_u16
    controller.rumble(low_freq: freq, high_freq: freq, duration_ms: 500) # rumble at 75% strength for 500 milliseconds
  when SDL::Event::ControllerDevice
    if event.type.controller_device_added?
      # when an SDL joystick / controller is added, event.which returns the device index, NOT the device instance id
      # since we are tracking controllers by instance id, we need to get it's instance id
      instance_id = SDL::GameController.instance_id(event.which)
      controllers[instance_id] = SDL::GameController.new(event.which)

      puts "Controller ##{instance_id} was connected"
    elsif event.type.controller_device_removed?
      # when a joystick / controller is removed, event.which returns the device instance id, NOT the device index
      # event.which will also auto increment for each new joystick the system detects
      next unless controller = controllers[event.which]?

      controller.finalize
      controllers.delete(event.which)
      puts "Controller ##{event.which} was disconnected"
    end
  when SDL::Event::ControllerAxis
    # when a controller axis is moved, event.which returns the device instance id, NOT the device index
    next unless controller = controllers[event.which]?
    next unless controller.rumble_triggers?

    # in this example, if you have a controller with rumble triggers, like an XBox one controller, pressing those
    # will rumble the triggers. we will ignore any other axis motions here.
    next unless trigger_axis.values.includes?(event.axis)

    left = event.axis == trigger_axis[:left] ? (0xffff * 1 // 2) : 0
    right = event.axis == trigger_axis[:right] ? (0xffff * 1 // 2) : 0

    # rumble the triggers at 50% for left and right for 250ms based on which trigger was pressed
    controller.rumble_triggers(left: left.to_u16, right: right.to_u16, duration_ms: 250)
  end

  renderer.draw_color = SDL::Color[255]
  renderer.clear

  x = (window.width - texture.width) // 2
  y = (window.height - texture.height) // 2
  renderer.copy(texture, dstrect: SDL::Rect[x, y, texture.width, texture.height])

  renderer.present
end

# clean up data
controllers.values.each(&.finalize)
[texture, renderer, window].each(&.finalize)
