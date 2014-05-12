module LitmosApiClient
  module Courses
    def courses(params={})
      get :courses, params
    end

    def find_course_by_id(id)
      get("courses/#{id}")
    rescue NotFound
      nil
    end

    def reset_user_course(options={})
      raise ArgumentError.new(":user_id is required") if options[:user_id].blank?
      raise ArgumentError.new(":course_id is required") if options[:course_id].blank?

      put("/users/#{options[:user_id]}/courses/#{options[:course_id]}/reset")
    end
    def find_courses_by_user_id(id)
      get("users/#{id}/courses")
    rescue NotFound
      nil
    end
  end
end