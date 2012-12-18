module Smart
  module REST
    class SMS
      include ClassSupportMixin
      set_attributes :mobile_number => nil, :message => nil, :access_code => nil
    end
  end
end