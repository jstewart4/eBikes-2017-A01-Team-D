using eBike.Data.Entities.Security;
using eBike.Data.POCOs;
using eBikeSystem.BLL;
using eBikeSystem.BLL.Security;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class WebSites_Checkout_PlaceOrder : System.Web.UI.Page
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

    protected void CouponRefreshBtn_Click(object sender, EventArgs e)
    {
        CouponListDD.SelectedIndex = CouponListDD.SelectedIndex;
        FinalTotalODS.DataBind();
    }

    protected void PlaceOrderBtn_Click(object sender, EventArgs e)
    {
        string username = User.Identity.Name;

        int couponid = int.Parse(CouponListDD.SelectedValue);

        FinalTotalPOCO totals = new FinalTotalPOCO();

        totals.SubTotal = decimal.Parse(TotalsGridView.DataKeys[0].Values[0].ToString());
        totals.Discount = decimal.Parse(TotalsGridView.DataKeys[0].Values[1].ToString());
        totals.GST = decimal.Parse(TotalsGridView.DataKeys[0].Values[2].ToString());
        totals.Total = decimal.Parse(TotalsGridView.DataKeys[0].Values[3].ToString());

        string paymethod = PaymentMethodRB.SelectedValue;

        MessageUserControl.TryRun(() =>
        {
            SalesController sysmgr = new SalesController();
            sysmgr.Place_Order(username, couponid, totals, paymethod);

        }, "Success", "Your order has been processed.");

        
    }
}