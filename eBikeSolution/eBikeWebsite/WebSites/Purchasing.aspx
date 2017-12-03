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
                Vendor Name: 
                <asp:Label ID="VendorName" runat="server" ></asp:Label><br />
                Vendor City: 
                <asp:Label ID="VendorCity" runat="server" ></asp:Label><br />
                Vendor Phone: 
                <asp:Label ID="VendorPhone" runat="server" ></asp:Label><br />
            </div>
        </div>
        <div class="col-md-12">
            <h2><asp:Label ID="CurrentPOLabel" runat="server" Text="Current Purchase Order"></asp:Label></h2>
        </div>
        <div class="col-md-12">
            <h2><asp:Label ID="CurrentInventoryLabel" runat="server" Text="Current Inventory"></asp:Label></h2>
            <asp:ListView ID="CurrentInventoryListview" runat="server" DataSourceID="PurchaseOrderPartsODS">
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
                            <asp:Label Text='<%# Eval("PurchasePrice") %>' runat="server" ID="PurchasePriceLabel" /></td>
                        <td>
                            <asp:LinkButton ID="AddButton" runat="server">Add </asp:LinkButton></td>
                    </tr>
                </AlternatingItemTemplate>
                <EmptyDataTemplate>
                    <table runat="server" style="background-color: #FFFFFF; border-collapse: collapse; border-color: #999999; border-style: none; border-width: 1px;">
                        <tr>
                            <td>No data was returned.</td>
                        </tr>
                    </table>
                </EmptyDataTemplate>
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
                            <asp:Label Text='<%# Eval("PurchasePrice") %>' runat="server" ID="PurchasePriceLabel" /></td>
                        <td>
                            <asp:LinkButton ID="AddButton" runat="server">Add </asp:LinkButton></td>
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
                            <td runat="server" style="text-align: center; background-color: #5D7B9D; font-family: Verdana, Arial, Helvetica, sans-serif; color: #FFFFFF">
                                <asp:DataPager runat="server" ID="DataPager1">
                                    <Fields>
                                        <asp:NextPreviousPagerField ButtonType="Button" ShowFirstPageButton="True" ShowLastPageButton="True"></asp:NextPreviousPagerField>
                                    </Fields>
                                </asp:DataPager>
                            </td>
                        </tr>
                    </table>
                </LayoutTemplate>
                <SelectedItemTemplate>
                    <tr style="background-color: #E2DED6; font-weight: bold; color: #333333;">
                        <td>
                            <asp:Label Text='<%# Eval("PurchaseOrderID") %>' runat="server" ID="PurchaseOrderIDLabel" /></td>
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
    <asp:ObjectDataSource ID="PurchaseOrderPartsODS" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="PurchaseOrderPartsList" TypeName="eBikeSystem.BLL.PurchasingController"></asp:ObjectDataSource>
    <asp:ObjectDataSource ID="VendorListODS" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="VendorList" TypeName="eBikeSystem.BLL.PurchasingController">
        <SelectParameters>
            <asp:ControlParameter ControlID="VendorName" PropertyName="Text" Name="vendorname" Type="String"></asp:ControlParameter>
            <asp:ControlParameter ControlID="VendorCity" PropertyName="Text" Name="vendorcity" Type="String"></asp:ControlParameter>
            <asp:ControlParameter ControlID="VendorPhone" PropertyName="Text" Name="vendorphone" Type="String"></asp:ControlParameter>
        </SelectParameters>
    </asp:ObjectDataSource>

</asp:Content>

