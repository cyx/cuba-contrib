require_relative "helper"

Cuba.plugin Cuba::With

class UserPhotos < Cuba
  define do
    on root do
      res.write "uid: %d" % vars[:user_id]
    end
  end
end

test do
  Cuba.define do
    on "users/:id/photos" do |id|
      with user_id: id do
        _, _, body = UserPhotos.call(req.env)

        body.each do |line|
          res.write line
        end
      end

      res.write vars.inspect
    end
  end

  _, _, body = Cuba.call({ "PATH_INFO" => "/users/1001/photos",
                           "SCRIPT_NAME" => "" })

  assert_response body, ["uid: 1001", "{}"]
end
