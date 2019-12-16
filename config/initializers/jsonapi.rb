JSONAPI::Rails.configure do |config|
  # # Set a default serializable class mapping for errors.
  config.jsonapi_errors_class = Hash.new { |h, k|
    names = k.to_s.split('::')
    klass = names.pop
    h[k] = [*names, "Serializable#{klass}"].join('::').safe_constantize
  }.tap { |h|
    h[:'ActiveModel::Errors'] = JSONAPI::Rails::SerializableActiveModelErrors
    h[:Hash] = JSONAPI::Rails::SerializableErrorHash
  }

  # # Set a default JSON API object.
  config.jsonapi_object = {
    version: '1.0'
  }

  # Set default meta.
  # A lambda/proc that will be eval'd in the controller context.
  config.jsonapi_meta = ->() { { server_time: Time.now.utc.iso8601 } }
end
