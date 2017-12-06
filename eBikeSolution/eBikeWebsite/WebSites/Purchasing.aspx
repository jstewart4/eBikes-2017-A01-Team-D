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
            <div class="form-group">
            <asp:Label ID="VendorListLabel" runat="server" Text="Vendor"></asp:Label>&nbsp;&nbsp;&nbsp;
                <asp:DropDownList ID="VendorDDL" runat="server" DataSourceID="VendorListODS" DataTextField="VendorName"
                    DataValueField="VendorID" CssClass="form-control" AutoPostBack="false" AppendDataBoundItems="true" />&nbsp;&nbsp;&nbsp;
                <asp:Button ID="GetCreatePOButton" runat="server" Text="Get / Create PO" OnClick="GetCreatePO_Click"/>
            </div>
            <div class="form-group">
                
                <asp:Label ID="VendorName" runat="server" Visible="false">Vendor Name:</asp:Label><br />
                
                <asp:Label ID="VendorCity" runat="server" Visible="false">Vendor City:</asp:Label><br />
                
                <asp:Label ID="VendorPhone" runat="server" Visible="false">Vendor Phone:</asp:Label><br />
            </div>
        </div>
        <div class="col-md-12">
            <h2><asp:Label ID="CurrentPOLabel" runat="server" Text="Current Purchase Order" Visible="false"></asp:Label></h2>
            <asp:ListView ID="CurrentPOListView" runat="server" OnItemCommand="CurrentPOListView_ItemCommand">
                <AlternatingItemTemplate>
                    <tr style="background-color: #FFFFFF; color: #284775;">
                        <td>
                            <asp:Label Text='<%# Eval("PartID") %>' runat="server" ID="PartIDLabel" /></td>
                        <td>
                            <asp:Label Text='<%# Eval("Description") %>' runat="server" ID="DescriptionLabel" /></td>
                        <td>
                            <asp:Label Text='<%# Eval("QuantityOnHand") %>' runat="server" ID="QuantityOnHandLabel" /></td>
                        <td>
                            <asp:Label Text='<%# Eval("QuantityOnOrder") %>' runat="server" ID="QuantityOnOrderLabel" /></td>
                        <td>
                            <asp:Label Text='<%# Eval("ReorderLevel") %>' runat="server" ID="ReorderLevelLabel" /></td>
                        <td>
                            <asp:TextBox Text='<%# Eval("Quantity") %>' runat="server" ID="QuantityLabel" Width="100px" /></td>
                        <td>
                            <asp:TextBox Text='<%# Eval("PurchasePrice", "{0:F2}") %>' runat="server" ID="PurchasePriceLabel" Width="100px" /></td>
                        <td>
                            <asp:Button runat="server" ID="RemoveFromPOButton" CommandArgument='<%# Eval("PartID") %>' Text="Remove" CssClass="btn btn-primary" Width="80px" /></td>
                    </tr>
                </AlternatingItemTemplate>
                <EditItemTemplate>
                    <tr style="background-color: #999999;">
                        <td>
                            <asp:Button runat="server" CommandName="Update" Text="Update" ID="UpdateButton" />
                            <asp:Button runat="server" CommandName="Cancel" Text="Cancel" ID="CancelButton" />
                        </td>
                        <td>
                            <asp:TextBox Text='<%# Bind("PartID") %>' runat="server" ID="PartIDTextBox" /></td>
                        <td>
                            <asp:TextBox Text='<%# Bind("Description") %>' runat="server" ID="DescriptionTextBox" /></td>
                        <td>
                            <asp:TextBox Text='<%# Bind("QuantityOnHand") %>' runat="server" ID="QuantityOnHandTextBox" /></td>
                        <td>
                            <asp:TextBox Text='<%# Bind("QuantityOnOrder") %>' runat="server" ID="QuantityOnOrderTextBox" /></td>
                        <td>
                            <asp:TextBox Text='<%# Bind("ReorderLevel") %>' runat="server" ID="ReorderLevelTextBox" /></td>
                        <td>
                            <asp:TextBox Text='<%# Bind("Quantity") %>' runat="server" ID="QuantityTextBox" /></td>
                        <td>
                            <asp:TextBox Text='<%# Bind("PurchasePrice") %>' runat="server" ID="PurchasePriceTextBox" /></td>
                    </tr>
                </EditItemTemplate>
                <EmptyDataTemplate>
                    <table runat="server" style="background-color: #FFFFFF; border-collapse: collapse; border-color: #999999; border-style: none; border-width: 1px;">
                        <tr>
                            <td>Nothing else to show for this Vendor.</td>
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
                            <asp:TextBox Text='<%# Bind("PartID") %>' runat="server" ID="PartIDTextBox" /></td>
                        <td>
                            <asp:TextBox Text='<%# Bind("Description") %>' runat="server" ID="DescriptionTextBox" /></td>
                        <td>
                            <asp:TextBox Text='<%# Bind("QuantityOnHand") %>' runat="server" ID="QuantityOnHandTextBox" /></td>
                        <td>
                            <asp:TextBox Text='<%# Bind("QuantityOnOrder") %>' runat="server" ID="QuantityOnOrderTextBox" /></td>
                        <td>
                            <asp:TextBox Text='<%# Bind("ReorderLevel") %>' runat="server" ID="ReorderLevelTextBox" /></td>
                        <td>
                            <asp:TextBox Text='<%# Bind("Quantity") %>' runat="server" ID="QuantityTextBox" /></td>
                        <td>
                            <asp:TextBox Text='<%# Bind("PurchasePrice") %>' runat="server" ID="PurchasePriceTextBox" /></td>
                    </tr>
                </InsertItemTemplate>
                <ItemTemplate>
                    <tr style="background-color: #E0FFFF; color: #333333;">
                        <td>
                            <asp:Label Text='<%# Eval("PartID") %>' runat="server" ID="PartIDLabel" /></td>
                        <td>
                            <asp:Label Text='<%# Eval("Description") %>' runat="server" ID="DescriptionLabel" /></td>
                        <td>
                            <asp:Label Text='<%# Eval("QuantityOnHand") %>' runat="server" ID="QuantityOnHandLabel" /></td>
                        <td>
                            <asp:Label Text='<%# Eval("QuantityOnOrder") %>' runat="server" ID="QuantityOnOrderLabel" /></td>
                        <td>
                            <asp:Label Text='<%# Eval("ReorderLevel") %>' runat="server" ID="ReorderLevelLabel" /></td>
                        <td>
                            <asp:TextBox Text='<%# Eval("Quantity") %>' runat="server" ID="QuantityLabel" Width="100px" /></td>
                        <td>
                            <asp:TextBox Text='<%# Eval("PurchasePrice", "{0:F2}") %>' runat="server" ID="PurchasePriceLabel" Width="100px" /></td>
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
                         <tr runat="server">
                            <td runat="server" style=""></td>
                        </tr>
                    </table>
                </LayoutTemplate>
                <SelectedItemTemplate>
                    <tr style="background-color: #E2DED6; font-weight: bold; color: #333333;">
                        <td>
                            <asp:Label Text='<%# Eval("PartID") %>' runat="server" ID="PartIDLabel" /></td>
                        <td>
                            <asp:Label Text='<%# Eval("Description") %>' runat="server" ID="DescriptionLabel" /></td>
                        <td>
                            <asp:Label Text='<%# Eval("QuantityOnHand") %>' runat="server" ID="QuantityOnHandLabel" /></td>
                        <td>
                            <asp:Label Text='<%# Eval("QuantityOnOrder") %>' runat="server" ID="QuantityOnOrderLabel" /></td>
                        <td>
                            <asp:Label Text='<%# Eval("ReorderLevel") %>' runat="server" ID="ReorderLevelLabel" /></td>
                        <td>
                            <asp:TextBox Text='<%# Eval("Quantity") %>' runat="server" ID="QuantityLabel" /></td>
                        <td>
                            <asp:TextBox Text='<%# Eval("PurchasePrice") %>' runat="server" ID="PurchasePriceLabel" /></td>
                    </tr>
                </SelectedItemTemplate>
            </asp:ListView>
        </div>
        <div class="col-md-12">
            <h2><asp:Label ID="CurrentInventoryLabel" runat="server" Text="Current Inventory" Visible="false"></asp:Label></h2>
            <asp:ListView ID="CurrentInventoryListView" runat="server" OnItemCommand="CurrentInventoryListView_ItemCommand">
                <AlternatingItemTemplate>
                    <tr style="background-color: #FFFFFF; color: #284775;">
                        <td>
                            <asp:Label Text='<%# Eval("PartID") %>' runat="server" ID="PartIDLabel" /></td>
                        <td>
                            <asp:Label Text='<%# Eval("Description") %>' runat="server" ID="DescriptionLabel" /></td>
                        <td>
                            <asp:Label Text='<%# Eval("QuantityOnHand") %>' runat="server" ID="QuantityOnHandLabel" /></td>
                        <td>
                            <asp:Label Text='<%# Eval("QuantityOnOrder") %>' runat="server" ID="QuantityOnOrderLabel" /></td>
                        <td>
                            <asp:Label Text='<%# Eval("ReorderLevel") %>' runat="server" ID="ReorderLevelLabel" /></td>
                        <td>
                            <asp:Label Text='<%# Eval("Buffer") %>' runat="server" ID="BufferLabel" /></td>
                        <td>
                            <asp:Label Text='<%# Eval("PurchasePrice", "{0:F2}") %>' runat="server" ID="PurchasePriceLabel" /></td>
                        <td>
                            <asp:Button runat="server" ID="AddToPOButton" CommandArgument='<%# Eval("PartID") %>' Text="Add" CssClass="btn btn-primary" Width="80px" /></td>
                    </tr>
                </AlternatingItemTemplate>
                <EditItemTemplate>
                    <tr style="background-color: #999999;">
                        <td>
                            <asp:Button runat="server" CommandName="Update" Text="Update" ID="UpdateButton" />
                            <asp:Button runat="server" CommandName="Cancel" Text="Cancel" ID="CancelButton" />
                        </td>
                        <td>
                            <asp:TextBox Text='<%# Bind("PartID") %>' runat="server" ID="PartIDTextBox" /></td>
                        <td>
                            <asp:TextBox Text='<%# Bind("Description") %>' runat="server" ID="DescriptionTextBox" /></td>
                        <td>
                            <asp:TextBox Text='<%# Bind("QuantityOnHand") %>' runat="server" ID="QuantityOnHandTextBox" /></td>
                        <td>
                            <asp:TextBox Text='<%# Bind("QuantityOnOrder") %>' runat="server" ID="QuantityOnOrderTextBox" /></td>
                        <td>
                            <asp:TextBox Text='<%# Bind("ReorderLevel") %>' runat="server" ID="ReorderLevelTextBox" /></td>
                        <td>
                            <asp:TextBox Text='<%# Bind("Buffer") %>' runat="server" ID="BufferTextBox" /></td>
                        <td>
                            <asp:TextBox Text='<%# Bind("PurchasePrice") %>' runat="server" ID="PurchasePriceTextBox" /></td>
                    </tr>
                </EditItemTemplate>
                <EmptyDataTemplate>
                    <table runat="server" style="background-color: #FFFFFF; border-collapse: collapse; border-color: #999999; border-style: none; border-width: 1px;">
                        <tr>
                            <td>Nothing else to show for this Vendor.</td>
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
                            <asp:TextBox Text='<%# Bind("PartID") %>' runat="server" ID="PartIDTextBox" /></td>
                        <td>
                            <asp:TextBox Text='<%# Bind("Description") %>' runat="server" ID="DescriptionTextBox" /></td>
                        <td>
                            <asp:TextBox Text='<%# Bind("QuantityOnHand") %>' runat="server" ID="QuantityOnHandTextBox" /></td>
                        <td>
                            <asp:TextBox Text='<%# Bind("QuantityOnOrder") %>' runat="server" ID="QuantityOnOrderTextBox" /></td>
                        <td>
                            <asp:TextBox Text='<%# Bind("ReorderLevel") %>' runat="server" ID="ReorderLevelTextBox" /></td>
                        <td>
                            <asp:TextBox Text='<%# Bind("Buffer") %>' runat="server" ID="BufferTextBox" /></td>
                        <td>
                            <asp:TextBox Text='<%# Bind("PurchasePrice") %>' runat="server" ID="PurchasePriceTextBox" /></td>
                    </tr>
                </InsertItemTemplate>
                <ItemTemplate>
                    <tr style="background-color: #E0FFFF; color: #333333;">
                        <td>
                            <asp:Label Text='<%# Eval("PartID") %>' runat="server" ID="PartIDLabel" /></td>
                        <td>
                            <asp:Label Text='<%# Eval("Description") %>' runat="server" ID="DescriptionLabel" /></td>
                        <td>
                            <asp:Label Text='<%# Eval("QuantityOnHand") %>' runat="server" ID="QuantityOnHandLabel" /></td>
                        <td>
                            <asp:Label Text='<%# Eval("QuantityOnOrder") %>' runat="server" ID="QuantityOnOrderLabel" /></td>
                        <td>
                            <asp:Label Text='<%# Eval("ReorderLevel") %>' runat="server" ID="ReorderLevelLabel" /></td>
                        <td>
                            <asp:Label Text='<%# Eval("Buffer") %>' runat="server" ID="BufferLabel" /></td>
                        <td>
                            <asp:Label Text='<%# Eval("PurchasePrice", "{0:F2}") %>' runat="server" ID="PurchasePriceLabel" /></td>
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
                <SelectedItemTemplate>
                    <tr style="background-color: #E2DED6; font-weight: bold; color: #333333;">
                        <td>
                            <asp:Label Text='<%# Eval("PartID") %>' runat="server" ID="PartIDLabel" /></td>
                        <td>
                            <asp:Label Text='<%# Eval("Description") %>' runat="server" ID="DescriptionLabel" /></td>
                        <td>
                            <asp:Label Text='<%# Eval("QuantityOnHand") %>' runat="server" ID="QuantityOnHandLabel" /></td>
                        <td>
                            <asp:Label Text='<%# Eval("QuantityOnOrder") %>' runat="server" ID="QuantityOnOrderLabel" /></td>
                        <td>
                            <asp:Label Text='<%# Eval("ReorderLevel") %>' runat="server" ID="ReorderLevelLabel" /></td>
                        <td>
                            <asp:Label Text='<%# Eval("Buffer") %>' runat="server" ID="BufferLabel" /></td>
                        <td>
                            <asp:Label Text='<%# Eval("PurchasePrice") %>' runat="server" ID="PurchasePriceLabel" /></td>
                    </tr>
                </SelectedItemTemplate>
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
    <asp:ObjectDataSource ID="SuggestedCurrentInventoryODS" runat="server"></asp:ObjectDataSource>
    <asp:ObjectDataSource ID="VendorListODS" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="VendorList" TypeName="eBikeSystem.BLL.PurchasingController"></asp:ObjectDataSource>
</asp:Content>

