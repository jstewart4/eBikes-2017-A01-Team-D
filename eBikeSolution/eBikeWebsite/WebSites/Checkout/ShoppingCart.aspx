<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="ShoppingCart.aspx.cs" Inherits="WebSites_Checkout_ShoppingCart" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" Runat="Server">
    <style>
        table{
            width: 100%;
        }
        td{
            padding: 10px;
        }
        th{
            text-align: center;
        }
    </style>
    <asp:Label ID="UserLabel" runat="server" Visible="false"></asp:Label>
    <div class="row">
        <div class="col-md-8">
            <div class="page-header">
                <h1>Your Shopping Cart <span aria-hidden="true" class="glyphicon glyphicon-shopping-cart"></span></h1>
                <asp:LinkButton ID="BackToShopping" runat="server"
                             CssClass="btn btn-primary" PostBackUrl="~/WebSites/Sales.aspx" >
                            <span aria-hidden="true" class="glyphicon glyphicon-menu-left"></span> Back to Shopping 
                </asp:LinkButton>
            </div>
        </div>
    </div>
    <div class="row">
        <div class="col-md-8">
            <asp:ListView ID="ShoppingCartList" runat="server" DataSourceID="ShoppingCartListODS">
                <AlternatingItemTemplate>
                    <tr style="background-color: #FFFFFF; color: #284775;">
                        <td>
                            <asp:Label Text='<%# Eval("Description") %>' runat="server" ID="DescriptionLabel" /></td>
                        <td style="width: 100px; text-align: center;">
                            <asp:Label Text='<%# Eval("Quantity") %>' runat="server" ID="QuantityLabel" /></td>
                        <td style="width: 100px; text-align: right;">
                            <asp:Label Text='<%# Eval("UnitPrice", "{0:C}") %>' runat="server" ID="UnitPriceLabel" /></td>
                        <td style="width: 100px; text-align: right;">
                            <asp:Label Text='<%# Eval("TotalPrice", "{0:C}") %>' runat="server" ID="TotalPriceLabel" /></td>
                    </tr>
                </AlternatingItemTemplate>
                <EditItemTemplate>
                    <tr style="background-color: #999999;">
                        <td>
                            <asp:Button runat="server" CommandName="Update" Text="Update" ID="UpdateButton" />
                            <asp:Button runat="server" CommandName="Cancel" Text="Cancel" ID="CancelButton" />
                        </td>
                       
                        <td>
                            <asp:TextBox Text='<%# Bind("Description") %>' runat="server" ID="DescriptionTextBox" /></td>
                        <td>
                            <asp:TextBox Text='<%# Bind("Quantity") %>' runat="server" ID="QuantityTextBox" /></td>
                        <td>
                            <asp:TextBox Text='<%# Bind("UnitPrice") %>' runat="server" ID="UnitPriceTextBox" /></td>
                        <td>
                            <asp:TextBox Text='<%# Bind("TotalPrice") %>' runat="server" ID="TotalPriceTextBox" /></td>
                    </tr>
                </EditItemTemplate>
                <EmptyDataTemplate>
                    <table runat="server" style="background-color: #FFFFFF; border-collapse: collapse; border-color: #999999; border-style: none; border-width: 1px;">
                        <tr>
                            <td>Shopping cart is empty.</td>
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
                            <asp:TextBox Text='<%# Bind("Description") %>' runat="server" ID="DescriptionTextBox" /></td>
                        <td>
                            <asp:TextBox Text='<%# Bind("Quantity") %>' runat="server" ID="QuantityTextBox" /></td>
                        <td>
                            <asp:TextBox Text='<%# Bind("UnitPrice") %>' runat="server" ID="UnitPriceTextBox" /></td>
                        <td>
                            <asp:TextBox Text='<%# Bind("TotalPrice") %>' runat="server" ID="TotalPriceTextBox" /></td>
                    </tr>
                </InsertItemTemplate>
                <ItemTemplate>
                    <tr style="background-color: #E0FFFF; color: #333333;">
                        
                        <td>
                            <asp:Label Text='<%# Eval("Description") %>' runat="server" ID="DescriptionLabel" /></td>
                        <td style="width: 100px; text-align: center;">
                            <asp:Label Text='<%# Eval("Quantity") %>' runat="server" ID="QuantityLabel" /></td>
                        <td style="width: 100px; text-align: right;">
                            <asp:Label Text='<%# Eval("UnitPrice", "{0:C}") %>' runat="server" ID="UnitPriceLabel" /></td>
                        <td style="width: 100px; text-align: right;">
                            <asp:Label Text='<%# Eval("TotalPrice", "{0:C}") %>' runat="server" ID="TotalPriceLabel" /></td>
                    </tr>
                </ItemTemplate>
                <LayoutTemplate>
                    <table runat="server">
                        <tr runat="server">
                            <td runat="server">
                                <table runat="server" id="itemPlaceholderContainer" style="background-color: #FFFFFF; border-collapse: collapse; border-style: none; font-family: Verdana, Arial, Helvetica, sans-serif;">
                                    <tr runat="server" style="background-color: #FFFFFF; color: #333333;">
                                        
                                        <th runat="server">Part Name</th>
                                        <th runat="server">Quantity</th>
                                        <th runat="server">Price(ea.)</th>
                                        <th runat="server">Total</th>
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
                            <asp:Label Text='<%# Eval("PartID") %>' runat="server" ID="PartIDLabel" /></td>
                        <td>
                            <asp:Label Text='<%# Eval("Description") %>' runat="server" ID="DescriptionLabel" /></td>
                        <td>
                            <asp:Label Text='<%# Eval("Quantity") %>' runat="server" ID="QuantityLabel" /></td>
                        <td>
                            <asp:Label Text='<%# Eval("UnitPrice") %>' runat="server" ID="UnitPriceLabel" /></td>
                        <td>
                            <asp:Label Text='<%# Eval("TotalPrice") %>' runat="server" ID="TotalPriceLabel" /></td>
                    </tr>
                </SelectedItemTemplate>
            </asp:ListView>
        </div>
    </div>
    <asp:ObjectDataSource ID="ShoppingCartListODS" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="ShoppingCartList" TypeName="eBikeSystem.BLL.SalesController">
        <SelectParameters>
            <asp:ControlParameter ControlID="UserLabel" PropertyName="Text" DefaultValue="" Name="username" Type="String"></asp:ControlParameter>

        </SelectParameters>
    </asp:ObjectDataSource>
</asp:Content>

