<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="Receiving.aspx.cs" Inherits="WebSites_Receiving" %>

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
            <h1 class="page-header">Receiving</h1>
        </div>
    </div>
    <uc1:MessageUserControl runat="server" ID="MessageUserControl" />
    <div class="row">
        <div class="col-md-12">
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
                        <td>
                            <asp:LinkButton ID="ViewOrder" runat="server">View Order</asp:LinkButton></td>
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
                         <td>
                            <asp:LinkButton ID="ViewOrder" runat="server">View Order</asp:LinkButton></td>
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
                        <td>
                            <asp:LinkButton ID="ViewOrder" runat="server">View Order</asp:LinkButton></td>
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
                        <td>
                            <asp:LinkButton ID="ViewOrder" runat="server" OnClick="ViewOrder_Click">View Order</asp:LinkButton></td>
                    </tr>
                </ItemTemplate>
                <LayoutTemplate>
                    <table runat="server">
                        <tr runat="server">
                            <td runat="server">
                                <table runat="server" id="itemPlaceholderContainer" style="background-color: #FFFFFF; border-collapse: collapse; border-color: #999999; border-style: none; border-width: 1px; font-family: Verdana, Arial, Helvetica, sans-serif;" border="1">
                                    <tr runat="server" style="background-color: #E0FFFF; color: #333333;">
                                        <th runat="server">PurchaseOrderID</th>
                                        <th runat="server">Order</th>
                                        <th runat="server">Order Date</th>
                                        <th runat="server">Vendor</th>
                                        <th runat="server">Contact</th>
                                        <th runat="server"></th>
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
                        <td>
                            <asp:LinkButton ID="ViewOrder" runat="server">View Order</asp:LinkButton></td>
                    </tr>
                </SelectedItemTemplate>
            </asp:ListView>
        </div>
    </div>
    </br>    
    <div class="row">
        <div class="col-md-12">
            <ul class="nav nav-tabs">
                <li><a href="#receiving" data-toggle="tab">Receiving</a></li>
                <li><a href="#unorderedParts" data-toggle="tab">Unordered Parts</a></li>
            </ul>

            <div class="tab-content">
                <div class="tab-pane fade" id="receiving">
                    <asp:UpdatePanel ID="UpdatePanelReceiving" runat="server">
                      <ContentTemplate>
                          <asp:ListView ID="ListView1" runat="server" DataSourceID="PODetailsODS">
                              <AlternatingItemTemplate>
                                  <tr style="background-color: #FFFFFF; color: #284775;">
                                      <td>
                                          <asp:Label Text='<%# Eval("PurchaseOrderID") %>' runat="server" ID="PurchaseOrderIDLabel" /></td>
                                      <td>
                                          <asp:Label Text='<%# Eval("PartID") %>' runat="server" ID="PartIDLabel" /></td>
                                      <td>
                                          <asp:Label Text='<%# Eval("Description") %>' runat="server" ID="DescriptionLabel" /></td>
                                      <td>
                                          <asp:Label Text='<%# Eval("QuantityOnOrder") %>' runat="server" ID="QuantityOnOrderLabel" /></td>
                                      <td>
                                          <asp:Label Text='<%# Eval("QuantityOutstanding") %>' runat="server" ID="QuantityOutstandingLabel" /></td>
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
                                          <asp:TextBox Text='<%# Bind("PartID") %>' runat="server" ID="PartIDTextBox" /></td>
                                      <td>
                                          <asp:TextBox Text='<%# Bind("Description") %>' runat="server" ID="DescriptionTextBox" /></td>
                                      <td>
                                          <asp:TextBox Text='<%# Bind("QuantityOnOrder") %>' runat="server" ID="QuantityOnOrderTextBox" /></td>
                                      <td>
                                          <asp:TextBox Text='<%# Bind("QuantityOutstanding") %>' runat="server" ID="QuantityOutstandingTextBox" /></td>
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
                                          <asp:TextBox Text='<%# Bind("PartID") %>' runat="server" ID="PartIDTextBox" /></td>
                                      <td>
                                          <asp:TextBox Text='<%# Bind("Description") %>' runat="server" ID="DescriptionTextBox" /></td>
                                      <td>
                                          <asp:TextBox Text='<%# Bind("QuantityOnOrder") %>' runat="server" ID="QuantityOnOrderTextBox" /></td>
                                      <td>
                                          <asp:TextBox Text='<%# Bind("QuantityOutstanding") %>' runat="server" ID="QuantityOutstandingTextBox" /></td>
                                  </tr>
                              </InsertItemTemplate>
                              <ItemTemplate>
                                  <tr style="background-color: #E0FFFF; color: #333333;">
                                      <td>
                                          <asp:Label Text='<%# Eval("PurchaseOrderID") %>' runat="server" ID="PurchaseOrderIDLabel" /></td>
                                      <td>
                                          <asp:Label Text='<%# Eval("PartID") %>' runat="server" ID="PartIDLabel" /></td>
                                      <td>
                                          <asp:Label Text='<%# Eval("Description") %>' runat="server" ID="DescriptionLabel" /></td>
                                      <td>
                                          <asp:Label Text='<%# Eval("QuantityOnOrder") %>' runat="server" ID="QuantityOnOrderLabel" /></td>
                                      <td>
                                          <asp:Label Text='<%# Eval("QuantityOutstanding") %>' runat="server" ID="QuantityOutstandingLabel" /></td>
                                  </tr>
                              </ItemTemplate>
                              <LayoutTemplate>
                                  <table runat="server">
                                      <tr runat="server">
                                          <td runat="server">
                                              <table runat="server" id="itemPlaceholderContainer" style="background-color: #FFFFFF; border-collapse: collapse; border-color: #999999; border-style: none; border-width: 1px; font-family: Verdana, Arial, Helvetica, sans-serif;" border="1">
                                                  <tr runat="server" style="background-color: #E0FFFF; color: #333333;">
                                                      <th runat="server">PurchaseOrderID</th>
                                                      <th runat="server">PartID</th>
                                                      <th runat="server">Description</th>
                                                      <th runat="server">QuantityOnOrder</th>
                                                      <th runat="server">QuantityOutstanding</th>
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
                                          <asp:Label Text='<%# Eval("PartID") %>' runat="server" ID="PartIDLabel" /></td>
                                      <td>
                                          <asp:Label Text='<%# Eval("Description") %>' runat="server" ID="DescriptionLabel" /></td>
                                      <td>
                                          <asp:Label Text='<%# Eval("QuantityOnOrder") %>' runat="server" ID="QuantityOnOrderLabel" /></td>
                                      <td>
                                          <asp:Label Text='<%# Eval("QuantityOutstanding") %>' runat="server" ID="QuantityOutstandingLabel" /></td>
                                  </tr>
                              </SelectedItemTemplate>
                          </asp:ListView>

                      </ContentTemplate>
                    </asp:UpdatePanel>
                </div> <%--end of pane--%> 
                
                <div class="tab-pane fade" id="unorderedParts">
                    <asp:UpdatePanel ID="UpdatePanelUnorderedParts" runat="server">

                    </asp:UpdatePanel>
                </div> <%--end of pane--%>          

            </div> <%--end of tab-content--%>
        </div> <%--end of col-md-12--%>
    </div> <%--end of row--%>


    <%--ODS for displaying the Outstanding orders--%>
    <asp:ObjectDataSource ID="OutstandingOrdersODS" runat="server" 
        OldValuesParameterFormatString="original_{0}" 
        SelectMethod="GetOutstandingPO" 
        TypeName="eBikeSystem.BLL.ReceivingController">
    </asp:ObjectDataSource>

    <%--ODS for displaying PO details--%>
    <asp:ObjectDataSource ID="PODetailsODS" runat="server" 
        OldValuesParameterFormatString="original_{0}" 
        SelectMethod="GetPODetails" 
        TypeName="eBikeSystem.BLL.ReceivingController">
        <SelectParameters>
            <asp:Parameter DefaultValue="458" Name="poID" Type="Int32"></asp:Parameter>

        </SelectParameters>
    </asp:ObjectDataSource>

</asp:Content>
