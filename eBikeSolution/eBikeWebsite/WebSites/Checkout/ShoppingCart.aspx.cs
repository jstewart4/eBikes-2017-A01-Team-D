using eBike.Data.Entities.Security;
using eBikeSystem.BLL;
using eBikeSystem.BLL.Security;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class WebSites_Checkout_ShoppingCart : System.Web.UI.Page
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
                if (!User.IsInRole(SecurityRoles.RegisteredUsers) && !User.IsInRole(SecurityRoles.Sales) && !User.IsInRole(SecurityRoles.WebsiteAdmins))
                {
                    Response.Redirect("~/Account/Login.aspx");
                }
                else
                {
                    UserLabel.Text = User.Identity.Name;
                }
            }

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

    protected void ShoppingCartList_ItemCommand(object sender, ListViewCommandEventArgs e)
    {
        ListViewDataItem row = e.Item as ListViewDataItem;

        string username = User.Identity.Name;

        int partid = int.Parse(e.CommandArgument.ToString());

        SalesController sysmgr = new SalesController();

        if (e.CommandName == "Change")
        {
            int quantity = int.Parse((row.FindControl("QuantityTextBox") as TextBox).Text.ToString());

            MessageUserControl.TryRun(() =>
            {

                sysmgr.Update_CartItem(username, partid, quantity);

            }, "Success", "Item quantity updated");
        }
        else
        {
            MessageUserControl.TryRun(() =>
            {

                sysmgr.Remove_CartItem(username, partid);

            }, "Success", "Item removed");
        }

        ShoppingCartList.DataBind();

        TotalsGridView.DataBind();
    }
}