module CoursesHelper
    def enrollment_button(course)
        if current_user
            if(course.user == current_user)
                link_to "Estatísticas", course_path(course)
            elsif course.enrollments.where(user: current_user).any?
                link_to course_path(course) do
                  "Você já está inscrito"
                  number_to_percentage(course.progress(current_user), precision: 0)
                end
            else
                link_to "Inscrever-se", new_course_enrollment_path(course), class: 'btn btn-success'
            end
        else
            link_to "Inscrever-se", new_course_enrollment_path(course), class: "btn btn-md btn-success"
        end
    end


    def review_button(course)
        user_course = course.enrollments.where(user: current_user)
        if current_user
          if user_course.any?
            if user_course.pending_review.any?
              link_to 'Adicione um avalição', edit_enrollment_path(user_course.first)
            else
              link_to 'Você já avaliou este curso', enrollment_path(user_course.first)
            end
          end
        end
      end
end
