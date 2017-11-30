require 'rails_helper'

RSpec.describe OrdersController, type: :controller do
  include Devise::Test::ControllerHelpers

  let(:user)       { create(:user) }
  let(:shop_owner) { create(:user, role: :admin) }

  before do
    sign_in user
    shop_owner
  end

  describe "POST #create" do
    subject(:create_request) do
      post :create, params: params
    end

    let(:product) { create(:product, quantity_in_stock: 10) }

    context "with valid params" do
      let(:params) { { order: { quantity: 1 }, product_id: product.id } }

      it "creates a new Order" do
        expect { create_request }.to change(Order, :count).by(1)
      end

      it "decreases product's quantity in stock" do
        expect { create_request }.to change { product.reload.quantity_in_stock }.from(10).to(9)
      end

      it "schedules worker with email notification for user" do
        expect { create_request }.to change { SendOrderPaymentNotificationWorker.jobs.size }.by(1)
      end

      it "notifies shop owner about new order" do
        expect { create_request }.to change { ActionMailer::Base.deliveries.count }.by(1)
      end

      it "redirects to the created order" do
        create_request
        expect(response).to redirect_to(Order.last)
      end

      context "when special offers are applied" do
        let(:current_special_offer) { create(:special_offer, discount: 10) }
        let(:old_special_offer) do
          create(:special_offer, discount: 50, date_from: 5.days.ago, date_to: 3.days.ago)
        end

        before do
          current_special_offer
          old_special_offer
        end

        it "takes only current offer into account" do
          create_request
          expect(Order.last.total_price).to eq(900.00)
        end
      end
    end

    context "with invalid params" do
      context "when there is not enough of product in stock" do
        let(:params) { { order: { quantity: 20 }, product_id: product.id } }

        it "does not create a new Order" do
          expect { create_request }.not_to change(Order, :count)
        end

        it "does not decrease product's quantity in stock" do
          expect { create_request }.not_to change(product, :quantity_in_stock)
        end

        it "does not schedule worker with email notification for user" do
          expect { create_request }.not_to change(SendOrderPaymentNotificationWorker.jobs, :size)
        end

        it "does not notifiy shop owner about new order" do
          expect { create_request }.not_to change(ActionMailer::Base.deliveries, :count)
        end
      end
    end
  end
end
