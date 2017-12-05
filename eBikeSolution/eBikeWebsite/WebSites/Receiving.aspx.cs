using eBike.Data.Entities.Security;
using eBikeSystem.BLL.Security;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using eBikeSystem.BLL;
using eBike.Data.DTOs;

public partial class WebSites_Receiving : System.Web.UI.Page
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
                if (!User.IsInRole(SecurityRoles.Receiving) && !User.IsInRole(SecurityRoles.WebsiteAdmins))
                {
                    Response.Redirect("~/Account/Login.aspx");
                }
            }

            if (User.IsInRole(SecurityRoles.Staff))
            {
                var sysmgr = new UserManager();

                string employeename = sysmgr.Get_EmployeeFullName(User.Identity.Name);

                EmployeeNameLabel.Text = "Current user: " + employeename;
            }
        }
        //Message.Text = "";
    }

    protected void CheckForException(object sender, ObjectDataSourceStatusEventArgs e)
    {
        MessageUserControl.HandleDataBoundException(e);
    }

    protected void ViewOrder_Click(object sender, EventArgs e)
    {
        int  poID = 0;

        GridViewRow item = (GridViewRow)((LinkButton)sender).NamingContainer; // gets info from one row.
        poID = int.Parse(((Label)item.FindControl("PurchaseOrderId")).Text);

        ReceivingController sysmng = new ReceivingController();
        VendorPurchaseOrderDetailsDTO vendorPODetails = sysmng.GetPODetails(poID);

        lblPONumber.Text = vendorPODetails.PurchaseOrderNumber.ToString();
        lblVendorName.Text = vendorPODetails.VendorName;
        lblVendorPhone.Text = vendorPODetails.VendorPhone;


        PODetailsGV.DataSource = vendorPODetails.PODetails;
        PODetailsGV.DataBind();
        
    }
}