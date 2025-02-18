class ChangeStartAndOfferDateToBeNullableInJobOffers < ActiveRecord::Migration[8.0]
  def change
    change_column :job_offers, :start_date, :date
    change_column :job_offers, :offer_date, :date
    change_column_null :job_offers, :start_date, true
    change_column_null :job_offers, :offer_date, true
  end
end
