module CoursesHelper
    def enrollment_button(course)
        if current_user
            if(course.user == current_user)
                link_to "Estatísticas", course_path(course)
            elsif course.enrollments.where(user: current_user).any?
                link_to "Você já está inscrito", course_path(course)
            else
                link_to "Inscrever-se", new_course_enrollment_path(course), class: 'btn btn-success'
            end
        else
            link_to "Inscrever-se", new_course_enrollment_path(course), class: "btn btn-md btn-success"
        end
    end
end
