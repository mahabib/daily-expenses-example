class Contact < Sequel::Model
  one_to_many :incomes,
    :key => :contact_id,
    :class => :Income
  
  one_to_many :expenses,
    :key => :contact_id,
    :class => :Expense

  def self.create_contact(user, params)
    params = Utils.strip_and_squeeze(params)
    params = Utils.symbolize(params)
    raise "Name is required!" if !params[:name]
    raise "Name already exists!" if Contact.where(name: params[:name]).count > 0
    raise "Contact Number is required!" if !params[:contact_no]
    
    self.create(
      user_id: user.id,
      name: params[:name],
      email: params[:email],
      contact_no: params[:contact_no],
      address: params[:address],
      notes: params[:address]
    )
  end

  def update_contact(params)
    params = Utils.strip_and_squeeze(params)
    params = Utils.symbolize(params)
    raise "Name is required!" if !params[:name]
    raise "Name already exists!" if Contact.where(name: params[:name]).count > 0
    raise "Contact Number is required!" if !params[:contact_no]

    update(
      name: params[:name] || name,
      email: params[:email] || email,
      contact_no: params[:contact_no] || contact_no,
      address: params[:address] || address,
      notes: params[:notes] || notes
    )
  end
end