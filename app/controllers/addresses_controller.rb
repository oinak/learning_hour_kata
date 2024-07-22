class AddressesController < ApplicationController
  def index
  end

  def edit
    contact = FindContact.new.call(params[:contact_id])
    render :edit_with_error and return if contact.nil?

    addresses = LookupPostcode.new.call(contact.fetch('postcode'))
    if addresses.any?
      render :edit_with_address_select, locals: { addresses: }
    else
      render :edit_with_manual_address_entry
    end
  end

  # def edit
  #   result = Findcontact
  #     .new
  #     .call(params[:contact_id])
  #     .or{|error| render :edit_with_error, locals: { error: } }
  #
  #   LookupPostcode
  #     .new
  #     .call(result.fetch('postcode'))
  #     .fmap { |addresses| render :edit_with_address_select, locals: { addresses: }}
  #     .or { render :edit_with_manual_address_entry }
  # end
end
