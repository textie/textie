module Api
  module V1
    module Courses
      module Lessons
        class ExercisesController < AuthorizedApiController
          expose :course
          expose :lesson, parent: :course, find_by: :order
          expose :exercises, from: :course

          def index; end
        end
      end
    end
  end
end
