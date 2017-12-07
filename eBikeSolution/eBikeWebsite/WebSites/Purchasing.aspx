<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="Purchasing.aspx.cs" Inherits="WebSites_Purchasing" %>

<%@ Register Src="~/UserControls/MessageUserControl.ascx" TagPrefix="uc1" TagName="MessageUserControl" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" Runat="Server">
    <style>
        .displayemployeename{
            float: right;
            margin-top: 20px;
            font-size: 18px;
        }
        td{
            padding: 10px;
        }
        th{
            padding: 10px;
            text-align: center;
        }
        .purchaseorder {
            margin-top: -50px;
        }

    </style>
    <asp:Label ID="EmployeeNameLabel" runat="server" CssClass="displayemployeename"></asp:Label>
    <div class="row">
        <div class="col-md-12">
            <h1 class="page-header">Purchasing</h1>
        </div>
    </div>
    <uc1:MessageUserControl runat="server" ID="MessageUserControl" />
    <div class="row">
        <div class="form-inline col-md-12">
            <div class="form-group col-md-5">
            <asp:Label ID="VendorListLabel" runat="server" Text="Vendor"></asp:Label>&nbsp;&nbsp;&nbsp;
                <asp:DropDownList ID="VendorDDL" runat="server" DataSourceID="VendorListODS" DataTextField="VendorName"
                    DataValueField="VendorID" CssClass="form-control" AutoPostBack="false" AppendDataBoundItems="true" />&nbsp;&nbsp;&nbsp;
                <asp:Button ID="GetCreatePOButton" CssClass="btn btn-primary" runat="server" Text="Get / Create PO" OnClick="GetCreatePO_Click"/>
            </div>
            <div class="col-md-4">
                <asp:GridView ID="VendorDetailGridView" runat="server" AutoGenerateColumns="False" DataSourceID="VendorDetailsODS" Visible="false">
                    <Columns>
                        <asp:BoundField DataField="VendorName" HeaderText="Vendor Name" SortExpression="VendorName"></asp:BoundField>
                        <asp:BoundField DataField="City" HeaderText="City" SortExpression="City"></asp:BoundField>
                        <asp:BoundField DataField="Phone" HeaderText="Phone" SortExpression="Phone"></asp:BoundField>
                    </Columns>
                </asp:GridView>
            </div>
        </div>
        <div class="col-md-12 purchaseorder">
            <h2><asp:Label ID="CurrentPOLabel" runat="server" Text="Current Purchase Order" Visible="false"></asp:Label></h2>
            <asp:ListView ID="CurrentPOListView" runat="server" OnItemCommand="CurrentPOListView_ItemCommand">
                <AlternatingItemTemplate>
                    <tr style="background-color: #FFFFFF; color: #284775;">
                        <td>
                            <asp:Label Text='<%# Eval("PartID") %>' runat="server" ID="PartIDLabel2" /></td>
                        <td>
                            <asp:Label Text='<%# Eval("Description") %>' runat="server" ID="DescriptionLabel2" /></td>
                        <td>
                            <asp:Label Text='<%# Eval("QuantityOnHand") %>' runat="server" ID="QuantityOnHandLabel2" /></td>
                        <td>
                            <asp:Label Text='<%# Eval("QuantityOnOrder") %>' runat="server" ID="QuantityOnOrderLabel2" /></td>
                        <td>
                            <asp:Label Text='<%# Eval("ReorderLevel") %>' runat="server" ID="ReorderLevelLabel2" /></td>
                        <td>
                            <asp:TextBox Text='<%# Eval("Quantity") %>' runat="server" ID="QuantityTextBox2" Width="100px" /></td>
                        <td>
                            <asp:TextBox Text='<%# Eval("PurchasePrice", "{0:F2}") %>' runat="server" ID="PurchasePriceTextBox2" Width="100px" /></td>
                        <td>
                            <asp:Button runat="server" ID="RemoveFromPOButton" CommandArgument='<%# Eval("PartID") %>' Text="Remove" CssClass="btn btn-primary" Width="80px" /></td>
                    </tr>
                </AlternatingItemTemplate>
                <EmptyDataTemplate>
                    <table runat="server" style="background-color: #FFFFFF; border-collapse: collapse; border-color: #999999; border-style: none; border-width: 1px;">
                        <tr>
                            <td>Nothing else to show for this Vendor.</td>
                        </tr>
                    </table>
                </EmptyDataTemplate>
                <ItemTemplate>
                    <tr style="background-color: #E0FFFF; color: #333333;">
                        <td>
                            <asp:Label Text='<%# Eval("PartID") %>' runat="server" ID="PartIDLabel2" /></td>
                        <td>
                            <asp:Label Text='<%# Eval("Description") %>' runat="server" ID="DescriptionLabel2" /></td>
                        <td>
                            <asp:Label Text='<%# Eval("QuantityOnHand") %>' runat="server" ID="QuantityOnHandLabel2" /></td>
                        <td>
                            <asp:Label Text='<%# Eval("QuantityOnOrder") %>' runat="server" ID="QuantityOnOrderLabel2" /></td>
                        <td>
                            <asp:Label Text='<%# Eval("ReorderLevel") %>' runat="server" ID="ReorderLevelLabel2" /></td>
                        <td>
                            <asp:TextBox Text='<%# Eval("Quantity") %>' runat="server" ID="QuantityTextBox2" Width="100px" /></td>
                        <td>
                            <asp:TextBox Text='<%# Eval("PurchasePrice", "{0:F2}") %>' runat="server" ID="PurchasePriceTextBox2" Width="100px" /></td>
                        <td>
                            <asp:Button runat="server" ID="RemoveFromPOButton" CommandArgument='<%# Eval("PartID") %>' Text="Remove" CssClass="btn btn-primary" Width="80px" /></td>
                    </tr>
                </ItemTemplate>
                <LayoutTemplate>
                    <table runat="server">
                        <tr runat="server">
                            <td runat="server">
                                <table runat="server" id="itemPlaceholderContainer" style="background-color: #FFFFFF; border-collapse: collapse; border-color: #999999; border-style: none; border-width: 1px; font-family: Verdana, Arial, Helvetica, sans-serif;" border="1">
                                    <tr runat="server" style="background-color: #E0FFFF; color: #333333;">
                                        <th runat="server">PartID</th>
                                        <th runat="server">Description</th>
                                        <th runat="server">QuantityOnHand</th>
                                        <th runat="server">QuantityOnOrder</th>
                                        <th runat="server">ReorderLevel</th>
                                        <th runat="server">Quantity</th>
                                        <th runat="server">PurchasePrice</th>
                                        <th runat="server"></th>
                                    </tr>
                                    <tr runat="server" id="itemPlaceholder"></tr>
                                </table>
                            </td>
                        </tr>
                    </table>
                </LayoutTemplate>
            </asp:ListView>
        </div>
        <div class="col-md-12">
            <h2><asp:Label ID="CurrentInventoryLabel" runat="server" Text="Current Inventory" Visible="false"></asp:Label></h2>
            <asp:ListView ID="CurrentInventoryListView" runat="server" OnItemCommand="CurrentInventoryListView_ItemCommand">
                <AlternatingItemTemplate>
                    <tr style="background-color: #FFFFFF; color: #284775;">
                        <td>
                            <asp:Label Text='<%# Eval("PartID") %>' runat="server" ID="PartIDLabel3" /></td>
                        <td>
                            <asp:Label Text='<%# Eval("Description") %>' runat="server" ID="DescriptionLabel3" /></td>
                        <td>
                            <asp:Label Text='<%# Eval("QuantityOnHand") %>' runat="server" ID="QuantityOnHandLabel3" /></td>
                        <td>
                            <asp:Label Text='<%# Eval("QuantityOnOrder") %>' runat="server" ID="QuantityOnOrderLabel3" /></td>
                        <td>
                            <asp:Label Text='<%# Eval("ReorderLevel") %>' runat="server" ID="ReorderLevelLabel3" /></td>
                        <td>
                            <asp:Label Text='<%# Eval("Buffer") %>' runat="server" ID="BufferLabel3" /></td>
                        <td>
                            <asp:Label Text='<%# Eval("PurchasePrice", "{0:F2}") %>' runat="server" ID="PurchasePriceLabel3" /></td>
                        <td>
                            <asp:Button runat="server" ID="AddToPOButton" CommandArgument='<%# Eval("PartID") %>' Text="Add" CssClass="btn btn-primary" Width="80px" /></td>
                    </tr>
                </AlternatingItemTemplate>
                <EmptyDataTemplate>
                    <table runat="server" style="background-color: #FFFFFF; border-collapse: collapse; border-color: #999999; border-style: none; border-width: 1px;">
                        <tr>
                            <td>Nothing else to show for this Vendor.</td>
                        </tr>
                    </table>
                </EmptyDataTemplate>
                <ItemTemplate>
                    <tr style="background-color: #E0FFFF; color: #333333;">
                        <td>
                            <asp:Label Text='<%# Eval("PartID") %>' runat="server" ID="PartIDLabel3" /></td>
                        <td>
                            <asp:Label Text='<%# Eval("Description") %>' runat="server" ID="DescriptionLabel3" /></td>
                        <td>
                            <asp:Label Text='<%# Eval("QuantityOnHand") %>' runat="server" ID="QuantityOnHandLabel3" /></td>
                        <td>
                            <asp:Label Text='<%# Eval("QuantityOnOrder") %>' runat="server" ID="QuantityOnOrderLabel3" /></td>
                        <td>
                            <asp:Label Text='<%# Eval("ReorderLevel") %>' runat="server" ID="ReorderLevelLabel3" /></td>
                        <td>
                            <asp:Label Text='<%# Eval("Buffer") %>' runat="server" ID="BufferLabel3" /></td>
                        <td>
                            <asp:Label Text='<%# Eval("PurchasePrice", "{0:F2}") %>' runat="server" ID="PurchasePriceLabel3" /></td>
                        <td>
                            <asp:Button runat="server" ID="AddToPOButton" CommandArgument='<%# Eval("PartID") %>' Text="Add" CssClass="btn btn-primary" Width="80px" /></td>
                    </tr>
                </ItemTemplate>
                <LayoutTemplate>
                    <table runat="server">
                        <tr runat="server">
                            <td runat="server">
                                <table runat="server" id="itemPlaceholderContainer" style="background-color: #FFFFFF; border-collapse: collapse; border-color: #999999; border-style: none; border-width: 1px; font-family: Verdana, Arial, Helvetica, sans-serif;" border="1">
                                    <tr runat="server" style="background-color: #E0FFFF; color: #333333;">
                                        <th runat="server">PartID</th>
                                        <th runat="server">Description</th>
                                        <th runat="server">QuantityOnHand</th>
                                        <th runat="server">QuantityOnOrder</th>
                                        <th runat="server">ReorderLevel</th>
                                        <th runat="server">Buffer</th>
                                        <th runat="server">PurchasePrice</th>
                                        <th runat="server"></th>
                                    </tr>
                                    <tr runat="server" id="itemPlaceholder"></tr>
                                </table>
                            </td>
                        </tr>
                         <tr runat="server">
                            <td runat="server" style=""></td>
                        </tr>
                    </table>
                </LayoutTemplate>
            </asp:ListView>
        </div>
     </div>
    <asp:ListView ID="ListView1" runat="server"></asp:ListView>
    <asp:ObjectDataSource ID="CurrentPOODS" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="ActivePurchaseOrder_ByVendor" TypeName="eBikeSystem.BLL.PurchasingController">
        <SelectParameters>
            <asp:ControlParameter ControlID="VendorDDL" PropertyName="SelectedValue" Name="vendorid" Type="Int32"></asp:ControlParameter>
        </SelectParameters>
    </asp:ObjectDataSource>
    <asp:ObjectDataSource ID="SuggestedPOODS" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="SuggestedPurchaseOrder_ByVendor" TypeName="eBikeSystem.BLL.PurchasingController">
        <SelectParameters>
            <asp:ControlParameter ControlID="VendorDDL" PropertyName="SelectedValue" Name="vendorid" Type="Int32"></asp:ControlParameter>
        </SelectParameters>
    </asp:ObjectDataSource>
    <asp:ObjectDataSource ID="CurrentInventoryODS" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="PartsInventory_ByVendor" TypeName="eBikeSystem.BLL.PurchasingController">
        <SelectParameters>
            <asp:ControlParameter ControlID="VendorDDL" PropertyName="SelectedValue" Name="vendorid" Type="Int32"></asp:ControlParameter>
        </SelectParameters>
    </asp:ObjectDataSource>
    <asp:ObjectDataSource ID="VendorListODS" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="VendorList" TypeName="eBikeSystem.BLL.PurchasingController"></asp:ObjectDataSource>
    <asp:ObjectDataSource ID="VendorDetailsODS" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="VendorDetails" TypeName="eBikeSystem.BLL.PurchasingController">
        <SelectParameters>
            <asp:ControlParameter ControlID="VendorDDL" PropertyName="SelectedValue" Name="vendorid" Type="Int32"></asp:ControlParameter>
        </SelectParameters>
    </asp:ObjectDataSource>
</asp:Content>

