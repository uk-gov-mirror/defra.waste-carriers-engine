class PaymentSummaryFormsController < FormsController
  def new
    super(PaymentSummaryForm, "payment_summary_form")
  end

  def create
    super(PaymentSummaryForm, "payment_summary_form")
  end
end
