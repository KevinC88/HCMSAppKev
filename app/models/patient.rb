class Patient < ActiveRecord::Base
has_many :requests
def self.search(search_for)
Patient.where(" \"patients\".\"lastname\" LIKE ?", "%#{search_for}%")
end

end
