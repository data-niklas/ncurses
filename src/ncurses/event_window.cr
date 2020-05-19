require "./window"

module NCurses
  abstract class EventWindow < Window


    @@windows = [] of EventWindow
    property visible
    @visible = true

    def self.windows
      @@windows
    end


    def initialize(height = nil, width = nil, y = 0, x = 0, @visible = true)
      max_height, max_width = NCurses.max_x, NCurses.max_y
      initialize(LibNCurses.newwin(height || max_height, width || max_width, y, x))
    end
    
    def initialize(@window : LibNCurses::Window)
    end

    def to_unsafe
      @window
    end

    # X and Y coordinates are shifted by the window position
    abstract def mouse_pressed(state : Mouse, x : Int32, y : Int32, z : Int32, device_id : Int16)

    def track()
      EventWindow.windows.push self
    end

    def untrack
      EventWindow.windows.delete self
    end

  end
end