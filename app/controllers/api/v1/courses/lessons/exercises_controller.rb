module Api
  module V1
    module Courses
      module Lessons
        class ExercisesController < AuthorizedApiController
          expose :course
          expose :lesson, parent: :course, find_by: :order
          expose :exercises, from: :lesson

          def index
            respond_with exercises, include: []
          end
        end
      end
    end
  end
end
