module ApplicationHelper

    def is_active(ctrl, act)
    	if (controller.controller_name == ctrl) && (controller.action_name == act)
    		"active"
    	else
    		""
    	end

    end

end
