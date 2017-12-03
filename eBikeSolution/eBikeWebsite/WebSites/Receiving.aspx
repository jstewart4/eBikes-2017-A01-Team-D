<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="Receiving.aspx.cs" Inherits="WebSites_Receiving" %>

<%@ Register Src="~/UserControls/MessageUserControl.ascx" TagPrefix="uc1" TagName="MessageUserControl" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" Runat="Server">
    <style>
        .displayemployeename{
            float: right;
            margin-top: 20px;
            font-size: 18px;
        }
    </style>
    <asp:Label ID="EmployeeNameLabel" runat="server" CssClass="displayemployeename"></asp:Label>
    <div>
        <h1>Receiving Page</h1>
    </div>
    <uc1:MessageUserControl runat="server" ID="MessageUserControl" />

    <asp:ListView ID="OutstandingOrdersList" runat="server" DataSourceID="OutstandingOrdersODS">
        <AlternatingItemTemplate>
            <tr style="background-color: #FFFFFF; color: #284775;">
                <td>
                    <asp:Label Text='<%# Eval("PurchaseOrderID") %>' runat="server" ID="PurchaseOrderIDLabel" /></td>
                <td>
                    <asp:Label Text='<%# Eval("PurchaseOrderNumber") %>' runat="server" ID="PurchaseOrderNumberLabel" /></td>
                <td>
                    <asp:Label Text='<%# Eval("OrderDate") %>' runat="server" ID="OrderDateLabel" /></td>
                <td>
                    <asp:Label Text='<%# Eval("Vendor") %>' runat="server" ID="VendorLabel" /></td>
                <td>
                    <asp:Label Text='<%# Eval("Phone") %>' runat="server" ID="PhoneLabel" /></td>
            </tr>
        </AlternatingItemTemplate>
        <EditItemTemplate>
            <tr style="background-color: #999999;">
                <td>
                    <asp:Button runat="server" CommandName="Update" Text="Update" ID="UpdateButton" />
                    <asp:Button runat="server" CommandName="Cancel" Text="Cancel" ID="CancelButton" />
                </td>
                <td>
                    <asp:TextBox Text='<%# Bind("PurchaseOrderID") %>' runat="server" ID="PurchaseOrderIDTextBox" /></td>
                <td>
                    <asp:TextBox Text='<%# Bind("PurchaseOrderNumber") %>' runat="server" ID="PurchaseOrderNumberTextBox" /></td>
                <td>
                    <asp:TextBox Text='<%# Bind("OrderDate") %>' runat="server" ID="OrderDateTextBox" /></td>
                <td>
                    <asp:TextBox Text='<%# Bind("Vendor") %>' runat="server" ID="VendorTextBox" /></td>
                <td>
                    <asp:TextBox Text='<%# Bind("Phone") %>' runat="server" ID="PhoneTextBox" /></td>
            </tr>
        </EditItemTemplate>
        <EmptyDataTemplate>
            <table runat="server" style="background-color: #FFFFFF; border-collapse: collapse; border-color: #999999; border-style: none; border-width: 1px;">
                <tr>
                    <td>No data was returned.</td>
                </tr>
            </table>
        </EmptyDataTemplate>
        <InsertItemTemplate>
            <tr style="">
                <td>
                    <asp:Button runat="server" CommandName="Insert" Text="Insert" ID="InsertButton" />
                    <asp:Button runat="server" CommandName="Cancel" Text="Clear" ID="CancelButton" />
                </td>
                <td>
                    <asp:TextBox Text='<%# Bind("PurchaseOrderID") %>' runat="server" ID="PurchaseOrderIDTextBox" /></td>
                <td>
                    <asp:TextBox Text='<%# Bind("PurchaseOrderNumber") %>' runat="server" ID="PurchaseOrderNumberTextBox" /></td>
                <td>
                    <asp:TextBox Text='<%# Bind("OrderDate") %>' runat="server" ID="OrderDateTextBox" /></td>
                <td>
                    <asp:TextBox Text='<%# Bind("Vendor") %>' runat="server" ID="VendorTextBox" /></td>
                <td>
                    <asp:TextBox Text='<%# Bind("Phone") %>' runat="server" ID="PhoneTextBox" /></td>
            </tr>
        </InsertItemTemplate>
        <ItemTemplate>
            <tr style="background-color: #E0FFFF; color: #333333;">
                <td>
                    <asp:Label Text='<%# Eval("PurchaseOrderID") %>' runat="server" ID="PurchaseOrderIDLabel" /></td>
                <td>
                    <asp:Label Text='<%# Eval("PurchaseOrderNumber") %>' runat="server" ID="PurchaseOrderNumberLabel" /></td>
                <td>
                    <asp:Label Text='<%# Eval("OrderDate") %>' runat="server" ID="OrderDateLabel" /></td>
                <td>
                    <asp:Label Text='<%# Eval("Vendor") %>' runat="server" ID="VendorLabel" /></td>
                <td>
                    <asp:Label Text='<%# Eval("Phone") %>' runat="server" ID="PhoneLabel" /></td>
            </tr>
        </ItemTemplate>
        <LayoutTemplate>
            <table runat="server">
                <tr runat="server">
                    <td runat="server">
                        <table runat="server" id="itemPlaceholderContainer" style="background-color: #FFFFFF; border-collapse: collapse; border-color: #999999; border-style: none; border-width: 1px; font-family: Verdana, Arial, Helvetica, sans-serif;" border="1">
                            <tr runat="server" style="background-color: #E0FFFF; color: #333333;">
                                <th runat="server">PurchaseOrderID</th>
                                <th runat="server">PurchaseOrderNumber</th>
                                <th runat="server">OrderDate</th>
                                <th runat="server">Vendor</th>
                                <th runat="server">Phone</th>
                            </tr>
                            <tr runat="server" id="itemPlaceholder"></tr>
                        </table>
                    </td>
                </tr>
                <tr runat="server">
                    <td runat="server" style="text-align: center; background-color: #5D7B9D; font-family: Verdana, Arial, Helvetica, sans-serif; color: #FFFFFF"></td>
                </tr>
            </table>
        </LayoutTemplate>
        <SelectedItemTemplate>
            <tr style="background-color: #E2DED6; font-weight: bold; color: #333333;">
                <td>
                    <asp:Label Text='<%# Eval("PurchaseOrderID") %>' runat="server" ID="PurchaseOrderIDLabel" /></td>
                <td>
                    <asp:Label Text='<%# Eval("PurchaseOrderNumber") %>' runat="server" ID="PurchaseOrderNumberLabel" /></td>
                <td>
                    <asp:Label Text='<%# Eval("OrderDate") %>' runat="server" ID="OrderDateLabel" /></td>
                <td>
                    <asp:Label Text='<%# Eval("Vendor") %>' runat="server" ID="VendorLabel" /></td>
                <td>
                    <asp:Label Text='<%# Eval("Phone") %>' runat="server" ID="PhoneLabel" /></td>
            </tr>
        </SelectedItemTemplate>
    </asp:ListView>


    <asp:ObjectDataSource ID="OutstandingOrdersODS" runat="server" 
        OldValuesParameterFormatString="original_{0}" 
        SelectMethod="GetOutstandingPO" 
        TypeName="eBikeSystem.BLL.ReceivingController">

    </asp:ObjectDataSource>


</asp:Content>
