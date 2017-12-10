using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using eBikeSystem.BLL;

public partial class WebSites_CurrentJob : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Request.IsAuthenticated)
        {
            Response.Redirect("~/Account/Login.aspx");
        }
        else
        {
            UserFullName.Text = User.Identity.Name.ToString();
            JobID.Text = Request.QueryString["id"];
            CustomerName.Text = Request.QueryString["name"];
            ContactNumber.Text = Request.QueryString["contact"];

            JobController sysmgr = new JobController();
            int jobId = int.Parse(JobID.Text);

            JobServiceGridView.DataSource = sysmgr.JobDetail(jobId);
            JobServiceGridView.DataBind();


        }
    }

    protected void PresetButton_Click(object sender, EventArgs e)
    {

    }

    protected void AddServiceButton_Click(object sender, EventArgs e)
    {

    }
}
