using eBike.Data.Entities.Security;
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
        }
        //Message.Text = "";
    }

    protected void CheckForException(object sender, ObjectDataSourceStatusEventArgs e)
    {
        MessageUserControl.HandleDataBoundException(e);
    }
}