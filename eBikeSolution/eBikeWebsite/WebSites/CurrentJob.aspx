<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="CurrentJob.aspx.cs" Inherits="WebSites_CurrentJob" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="Server">
    <div class="jumbotron">
        <h1>Current Job</h1>
    </div>
    <div class="row col-md-12">
        <div class="form-group" style="padding-bottom: 2rem; padding-top: 2rem;">

            <asp:Label CssClass="col-xs-1" runat="server" Text="User: " AssociatedControlID="UserFullName"></asp:Label>

            <asp:Label CssClass="col-sm-1" ID="UserFullName" runat="server"></asp:Label>

            <asp:Label CssClass="col-sm-1" runat="server" Text="Job: " AssociatedControlID="JobID"></asp:Label>

            <asp:Label CssClass="col-sm-1" ID="JobID" runat="server"></asp:Label>

            <asp:Label CssClass="col-sm-1" runat="server" Text="Customer: " AssociatedControlID="CustomerName"></asp:Label>

            <asp:Label CssClass="col-sm-3" ID="CustomerName" runat="server"></asp:Label>

            <asp:Label CssClass="col-sm-1" runat="server" Text="Contact: " AssociatedControlID="ContactNumber"></asp:Label>

            <asp:Label CssClass="col-sm-2" ID="ContactNumber" runat="server"></asp:Label>
        </div>
    </div>
    <div class="row col-md-12">
        <div class="form-group" style="padding-bottom: 2rem; padding-top: 2rem;">
           
             <asp:Label CssClass="col-sm-1" runat="server" Text="Presets: " AssociatedControlID="PresetDDL"></asp:Label>
            <asp:DropDownList CssClass="col-sm-2" ID="PresetDDL" AppendDataBoundItems="true"
                runat="server" DataSourceID="PresetDDLODS" DataTextField="Description"
                DataValueField="StandardJobID" OnSelectedIndexChanged="PresetDDL_SelectedIndexChanged">
                <asp:ListItem Value="0" Enabled="true" Selected="True">Select...</asp:ListItem>
            </asp:DropDownList>
            <asp:Button CssClass="col-sm-1" ID="PresetButton" runat="server" Text="Select" OnClick="PresetButton_Click" />

            <asp:Label CssClass="col-sm-1" runat="server" Text="Coupon: " AssociatedControlID="CouponDDL"></asp:Label>
            <asp:DropDownList CssClass="col-sm-2" ID="CouponDDL" AppendDataBoundItems="true" runat="server" DataSourceID="CouponDDLODS" 
                DataTextField="CouponIDValue" DataValueField="CouponID">
                <asp:ListItem Value="0" Enabled="true" Selected="True">Select...</asp:ListItem>
            </asp:DropDownList>
            <asp:Button CssClass="col-sm-1" ID="AddServiceButton" runat="server" Text="Add Service" OnClick="AddServiceButton_Click" />

        </div>
    </div>
    <%-- OnDataBinding="PresetButton_Click" --%>
    <div class="row col-md-12">
        <div class="form-group" style="padding-bottom: 2rem; padding-top: 2rem;">
            <asp:Label CssClass="col-sm-1" AssociatedControlID="Description" runat="server" Text="Description"></asp:Label>
            <asp:TextBox CssClass="col-sm-1" ID="Description" runat="server" Text="" Width="250px" ></asp:TextBox>
            <asp:Label CssClass="col-sm-1" AssociatedControlID="Hours" runat="server" Text="Hours: "></asp:Label>
            <asp:TextBox CssClass="col-sm-1" ID="Hours" runat="server"></asp:TextBox>
        </div>
    </div>
    <div class="row col-md-12">
        <div class="form-group" style="padding-bottom: 2rem; padding-top: 2rem;">
            <asp:Label CssClass="col-sm-1" AssociatedControlID="Comments" runat="server" Text="Comments: "></asp:Label>
            <asp:TextBox CssClass="col-sm-1" ID="Comments" runat="server" Height="100" Width="800px"></asp:TextBox>
        </div>
    </div>

    <div class="row col-md-12">
        <asp:GridView ID="JobServiceGridView" runat="server" AllowPaging="True"
            CssClass="table table-bordered table-striped table-hover" AutoGenerateColumns="False">
            <Columns>
                 <asp:TemplateField >
                    <ItemTemplate>
                        <asp:LinkButton ID="RemoveLinkButton" runat="server">Remove</asp:LinkButton>
                    </ItemTemplate>
                </asp:TemplateField>

                <asp:TemplateField SortExpression="JobDetailID" HeaderText="Description">
                    <ItemTemplate>
                        <asp:Label runat="server" Text='<%# Bind("Description") %>' ID="DescriptionLabel"></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>

                <asp:TemplateField SortExpression="JobDetailID" HeaderText="Hours">
                    <ItemTemplate>
                        <asp:Label runat="server" Text='<%# Bind("JobHours") %>' ID="DescriptionLabel"></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>

                <asp:TemplateField SortExpression="JobDetailID" HeaderText="Coupon">
                    <ItemTemplate>
                        <asp:Label runat="server" Text='<%# Bind("CouponID") %>' ID="DescriptionLabel"></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>

                <asp:TemplateField SortExpression="JobDetailID" HeaderText="Comments">
                    <ItemTemplate>
                        <asp:Label runat="server" Text='<%# Bind("Comments") %>' ID="DescriptionLabel"></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>

            </Columns>


        </asp:GridView>
    </div>

    <%-- ods area below --%>
    <asp:ObjectDataSource ID="CurrentJobGridViewODS" runat="server"></asp:ObjectDataSource>

    <asp:ObjectDataSource ID="PresetDDLODS" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="presets" TypeName="eBikeSystem.BLL.JobController"></asp:ObjectDataSource>

    <asp:ObjectDataSource ID="CouponDDLODS" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="coupon" TypeName="eBikeSystem.BLL.JobController"></asp:ObjectDataSource>

    <asp:ObjectDataSource ID="JobServiceGridViewODS" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="JobDetail" TypeName="eBikeSystem.BLL.JobController"></asp:ObjectDataSource>

</asp:Content>

