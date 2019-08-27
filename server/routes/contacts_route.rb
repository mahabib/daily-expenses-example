require_relative '../helpers/json-web-token'

App.route("contacts") do |r|
  @current_user = JsonWebToken.authorize_request(r.headers['Authorization'])
  r.on String do |contact_id|
    r.get do
      contact = @current_user.contacts.where(id: contact_id).first
      raise "Invalid Contact!" if !contact
      {
        success: true,
        values: contact.values
      }
    end

    r.put do
      contact.update_contact(params)
      {
        success: true
      }
    end

    r.delete do
      contact.destroy
      {
        success: true
      }
    end
  end # /contacts/:id
  r.post do
    Contact.create_contact(@current_user, params)
    {
      success: true
    }
  end

  r.get do
    {
      success: true,
      values: Contact.all.collect{|u| u.values}
    }
  end
end