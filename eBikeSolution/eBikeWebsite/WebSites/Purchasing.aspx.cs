using eBike.Data.Entities;
using eBike.Data.Entities.Security;
using eBikeSystem.BLL;
using eBikeSystem.BLL.Security;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class WebSites_Purchasing : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            // are you logged on?
            if (!Request.IsAuthenticated)
            {
                Response.Redirect("~/Account/Login.aspx");
            }
            else
            {
                // now that you are logged on, are you in the approved role for this page?
                if (!User.IsInRole(SecurityRoles.Purchasing) && !User.IsInRole(SecurityRoles.WebsiteAdmins))
                {
                    Response.Redirect("~/Account/Login.aspx");
                }
            }

            // this is to show the currently logged in users name on the page
            if (User.IsInRole(SecurityRoles.Staff))
            {
                var sysmgr = new UserManager();

                string employeename = sysmgr.Get_EmployeeFullName(User.Identity.Name);

                EmployeeNameLabel.Text = "Current user: " + employeename;
            }
        }
    }

    protected void CheckForException(object sender, ObjectDataSourceStatusEventArgs e)
    {
        MessageUserControl.HandleDataBoundException(e);
    }

    public void hideAll()
    {
        CurrentPOListView.Visible = false;
        CurrentInventoryListView.Visible = false;
        VendorDetailGridView.Visible = false;
        CurrentPOLabel.Visible = false;
        CurrentInventoryLabel.Visible = false;
        UpdateButton.Visible = false;
        PlaceButton.Visible = false;
        DeleteButton.Visible = false;
        ClearButton.Visible = false;
        TotalsGridView.Visible = false;
    }
    public void showAll()
    {
        CurrentPOListView.Visible = true;
        CurrentInventoryListView.Visible = true;
        VendorDetailGridView.Visible = true;
        CurrentPOLabel.Visible = true;
        CurrentInventoryLabel.Visible = true;
        UpdateButton.Visible = true;
        PlaceButton.Visible = true;
        DeleteButton.Visible = true;
        ClearButton.Visible = true;
        TotalsGridView.Visible = true;
    }

    protected void GetCreatePO_Click(object sender, EventArgs e)
    {
        // only show the GridViews, Listviews and buttons on click
        showAll();

        // set the current active order ODS to the listview
        CurrentPOListView.DataSourceID = "CurrentPOODS";
        CurrentPOListView.DataBind();

        if (CurrentPOListView.Items.Count == 0) // then create the suggested putchase order
        {
            // set the suggested order ODS to the listview and bind it
            CurrentPOListView.DataSourceID = "SuggestedPOODS";
            CurrentPOListView.DataBind();

            PurchaseOrder purchaseorder = new PurchaseOrder();

            // get the vendorID from the DDL and set it into purchaseorder
            purchaseorder.VendorID = int.Parse(VendorDDL.SelectedValue);

            // create new list to store the purchase order details
            List<PurchaseOrderDetail> purchaseorderdetails = new List<PurchaseOrderDetail>();

            // go through the needed rows of the listview to get the data needed for suggested order and add it to the purchaseorderdetails list
            foreach (ListViewItem item in CurrentPOListView.Items)
            {
                PurchaseOrderDetail purchaseorderdetail = new PurchaseOrderDetail();

                purchaseorderdetail.PartID = int.Parse((item.FindControl("PartIDLabel2") as Label).Text.ToString());
                purchaseorderdetail.Quantity = int.Parse((item.FindControl("QuantityTextBox2") as TextBox).Text.ToString());
                purchaseorderdetail.PurchasePrice = decimal.Parse((item.FindControl("PurchasePriceTextBox2") as TextBox).Text.ToString());

                purchaseorderdetails.Add(purchaseorderdetail);
            }


            // pass the data to the controller to create the suggested order
            var sysmgr = new PurchasingController();
            MessageUserControl.TryRun(() =>
            {
                sysmgr.NewSuggestedOrder(purchaseorder, purchaseorderdetails);

            }, "Success", "Suggested purchase order created.");

            TotalsGridView.DataBind();

            PurchaseOrder purchaseordertotals = new PurchaseOrder();

            // pass the subtotal, taxamount to purchaseorder here
            purchaseordertotals.SubTotal = Math.Round(decimal.Parse(TotalsGridView.DataKeys[0].Values[0].ToString()),2);
            purchaseordertotals.TaxAmount = Math.Round(decimal.Parse(TotalsGridView.DataKeys[0].Values[1].ToString()),2);

            // pass the totals to the controller to update the suggested order
            var newsysmgr = new PurchasingController();
            MessageUserControl.TryRun(() =>
            {
                newsysmgr.UpdateTotalsSuggestedOrder(purchaseorder, purchaseordertotals);

            }, "Success", "Suggested purchase order totals updated.");

            // Bind the new current inventory for the suggested order
            CurrentInventoryListView.DataSourceID = "CurrentInventoryODS";
            CurrentInventoryListView.DataBind();

            // this is for if the vendor has no parts available to be automatically put on the suggested purchase order
            if (CurrentPOListView.Items.Count == 0)
            {
                MessageUserControl.ShowInfo("Information", "No active purchase order found. A suggested purchase order has been created, however, no parts from this vendor are eligible for the suggested purchase order.");
            }
            else // else, the suggested parts will be shown on the suggested order
            {
                MessageUserControl.ShowInfo("Information", "No active purchase order found. A suggested purchase order has been created.");
            }
        }
        else
        {
            // Bind the new current inventory for the current active order
            CurrentInventoryListView.DataSourceID = "CurrentInventoryODS";
            CurrentInventoryListView.DataBind();

            MessageUserControl.ShowInfo("Information", "Current active order found.");
        }
    }

    protected void CurrentPOListView_ItemCommand(object sender, ListViewCommandEventArgs e)
    {
        // !*!*! ADD THE REMOVE BUTTON LOGIC HERE
    }

    protected void CurrentInventoryListView_ItemCommand(object sender, ListViewCommandEventArgs e)
    {
        // !*!*! ADD THE ADD BUTTON LOGIC HERE
    }

    protected void UpdateButton_Click(object sender, EventArgs e)
    {
        PurchaseOrder purchaseorder = new PurchaseOrder();

        // get the vendorID from the DDL and set it into purchaseorder
        purchaseorder.VendorID = int.Parse(VendorDDL.SelectedValue);

        List<PurchaseOrderDetail> purchaseorderdetails = new List<PurchaseOrderDetail>();

        foreach (ListViewItem item in CurrentPOListView.Items)
        {

            PurchaseOrderDetail purchaseorderdetail = new PurchaseOrderDetail();

            purchaseorderdetail.PurchaseOrderDetailID = int.Parse((item.FindControl("PurchaseOrderDetailIDLabel2") as Label).Text.ToString());
            purchaseorderdetail.PartID = int.Parse((item.FindControl("PartIDLabel2") as Label).Text.ToString());
            purchaseorderdetail.Quantity = int.Parse((item.FindControl("QuantityTextBox2") as TextBox).Text.ToString());
            purchaseorderdetail.PurchasePrice = decimal.Parse((item.FindControl("PurchasePriceTextBox2") as TextBox).Text.ToString());

            purchaseorderdetails.Add(purchaseorderdetail);
        }

       var sysmgr = new PurchasingController();

        MessageUserControl.TryRun(() =>
        {
            sysmgr.Update_PurchaseOrder(purchaseorder, purchaseorderdetails);

        }, "Success", "Purchase Order item(s) quantity and purchase price updated");

        CurrentPOListView.DataSourceID = "CurrentPOODS";
        CurrentPOListView.DataBind();
        TotalsGridView.DataBind();

    }

    protected void PlaceButton_Click(object sender, EventArgs e)
    {
        PurchaseOrder purchaseorder = new PurchaseOrder();

        // get the vendorID from the DDL and set it into purchaseorder
        purchaseorder.VendorID = int.Parse(VendorDDL.SelectedValue);

        List<PurchaseOrderDetail> purchaseorderdetails = new List<PurchaseOrderDetail>();

        foreach (ListViewItem item in CurrentPOListView.Items)
        {
            PurchaseOrderDetail purchaseorderdetail = new PurchaseOrderDetail();

            //purchaseorderdetail.PurchaseOrderDetailID = int.Parse((item.FindControl("PurchaseOrderDetailIDLabel2") as Label).Text.ToString());
            purchaseorderdetail.PartID = int.Parse((item.FindControl("PartIDLabel2") as Label).Text.ToString());
            purchaseorderdetail.Quantity = int.Parse((item.FindControl("QuantityTextBox2") as TextBox).Text.ToString());
            // purchaseorderdetail.PurchasePrice = decimal.Parse((item.FindControl("PurchasePriceTextBox2") as TextBox).Text.ToString());

            purchaseorderdetails.Add(purchaseorderdetail);
        }

        var sysmgr = new PurchasingController();

        MessageUserControl.TryRun(() =>
        {
            sysmgr.Place_PurchaseOrder(purchaseorder, purchaseorderdetails);

        }, "Success", "Purchase Order has been placed.");

        hideAll();
        VendorDDL.SelectedValue = "0";
    }

    protected void DeleteButton_Click(object sender, EventArgs e)
    {
        MessageUserControl.TryRun(() =>
        {
            int purchaseOrderID = 0;

            foreach (ListViewItem item in CurrentPOListView.Items)
            {
                purchaseOrderID = int.Parse((item.FindControl("PurchaseOrderIDLabel2") as Label).Text.ToString());
            }

            PurchasingController sysmgr = new PurchasingController();
            sysmgr.PurchaseOrder_Delete(purchaseOrderID);

            hideAll();

        }, "Removed", "Purchase order has been removed.");
    }

    protected void ClearButton_Click(object sender, EventArgs e)
    {
        hideAll();
        VendorDDL.SelectedValue = "0";
        MessageUserControl.ShowInfo("Information", "Webpage cleared.");
    }
}