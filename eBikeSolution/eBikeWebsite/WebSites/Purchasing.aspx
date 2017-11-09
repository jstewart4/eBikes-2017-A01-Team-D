<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="Purchasing.aspx.cs" Inherits="WebSites_Purchasing" %>

<%@ Register Src="~/UserControls/MessageUserControl.ascx" TagPrefix="uc1" TagName="MessageUserControl" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" Runat="Server">
    <div>
        <h1>Purchasing Page</h1>
    </div>
    <uc1:MessageUserControl runat="server" ID="MessageUserControl" />
</asp:Content>

