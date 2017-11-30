<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="Jobing.aspx.cs" Inherits="WebSites_Jobing" %>

<%@ Register Src="~/UserControls/MessageUserControl.ascx" TagPrefix="uc1" TagName="MessageUserControl" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="Server">
    <style>
        .displayemployeename {
            float: right;
            margin-top: 20px;
            font-size: 18px;
        }
    </style>
    <asp:Label ID="EmployeeNameLabel" runat="server" CssClass="displayemployeename"></asp:Label>
    <div>
        <h1>Jobing Page</h1>
    </div>
    <uc1:MessageUserControl runat="server" ID="MessageUserControl" />

    <div class="row">
        <div class="col-md-3">
            
                <h2><asp:Label ID="CurrentJobs" runat="server" Text="Current Jobs"></asp:Label></h2>
                    
            <asp:ListView ID="CurrentJobsListView" runat="server" 
                DataSourceID="CurrentJobsListViewODS">

                <AlternatingItemTemplate>
                    <tr style="background-color: #FFFFFF; color: #284775;">
                        <td>
                            <asp:Label Text='<%# Eval("JobID") %>' runat="server" ID="JobIDLabel" /></td>
                        <td>
                            <asp:Label Text='<%# Eval("JobDateIn") %>' runat="server" ID="JobDateInLabel" /></td>
                        <td>
                            <asp:Label Text='<%# Eval("JobDateStarted") %>' runat="server" ID="JobDateStartedLabel" /></td>
                        <td>
                            <asp:Label Text='<%# Eval("JobDateDone") %>' runat="server" ID="JobDateDoneLabel" /></td>
                        <td>
                            <asp:Label Text='<%# Eval("Name") %>' runat="server" ID="NameLabel" /></td>
                        <td>
                            <asp:Label Text='<%# Eval("ContactPhone") %>' runat="server" ID="ContactPhoneLabel" /></td>
                        <td>
                            <asp:LinkButton ID="ViewButton" runat="server">View </asp:LinkButton>
                        </td>
                    </tr>
                </AlternatingItemTemplate>
                <EditItemTemplate>
                    <tr style="background-color: #999999;">
                        <td>
                            <asp:Button runat="server" CommandName="Update" Text="Update" ID="UpdateButton" />
                            <asp:Button runat="server" CommandName="Cancel" Text="Cancel" ID="CancelButton" />
                        </td>
                        <td>
                            <asp:TextBox Text='<%# Bind("JobID") %>' runat="server" ID="JobIDTextBox" /></td>
                        <td>
                            <asp:TextBox Text='<%# Bind("JobDateIn") %>' runat="server" ID="JobDateInTextBox" /></td>
                        <td>
                            <asp:TextBox Text='<%# Bind("JobDateStarted") %>' runat="server" ID="JobDateStartedTextBox" /></td>
                        <td>
                            <asp:TextBox Text='<%# Bind("JobDateDone") %>' runat="server" ID="JobDateDoneTextBox" /></td>
                        <td>
                            <asp:TextBox Text='<%# Bind("Name") %>' runat="server" ID="NameTextBox" /></td>
                        <td>
                            <asp:TextBox Text='<%# Bind("ContactPhone") %>' runat="server" ID="ContactPhoneTextBox" /></td>
                     <td>
                            <asp:LinkButton ID="ViewButton" runat="server">View </asp:LinkButton>
                        </td>
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
                            <asp:TextBox Text='<%# Bind("JobID") %>' runat="server" ID="JobIDTextBox" /></td>
                        <td>
                            <asp:TextBox Text='<%# Bind("JobDateIn") %>' runat="server" ID="JobDateInTextBox" /></td>
                        <td>
                            <asp:TextBox Text='<%# Bind("JobDateStarted") %>' runat="server" ID="JobDateStartedTextBox" /></td>
                        <td>
                            <asp:TextBox Text='<%# Bind("JobDateDone") %>' runat="server" ID="JobDateDoneTextBox" /></td>
                        <td>
                            <asp:TextBox Text='<%# Bind("Name") %>' runat="server" ID="NameTextBox" /></td>
                        <td>
                            <asp:TextBox Text='<%# Bind("ContactPhone") %>' runat="server" ID="ContactPhoneTextBox" /></td>
                    </tr>
                </InsertItemTemplate>
                <ItemTemplate>
                    <tr style="background-color: #E0FFFF; color: #333333;">
                        <td>
                            <asp:Label Text='<%# Eval("JobID") %>' runat="server" ID="JobIDLabel" /></td>
                        <td>
                            <asp:Label Text='<%# Eval("JobDateIn") %>' runat="server" ID="JobDateInLabel" /></td>
                        <td>
                            <asp:Label Text='<%# Eval("JobDateStarted") %>' runat="server" ID="JobDateStartedLabel" /></td>
                        <td>
                            <asp:Label Text='<%# Eval("JobDateDone") %>' runat="server" ID="JobDateDoneLabel" /></td>
                        <td>
                            <asp:Label Text='<%# Eval("Name") %>' runat="server" ID="NameLabel" /></td>
                        <td>
                            <asp:Label Text='<%# Eval("ContactPhone") %>' runat="server" ID="ContactPhoneLabel" /></td>
                     <td>
                            <asp:LinkButton ID="ViewButton" runat="server">View </asp:LinkButton>
                        </td>
                    </tr>
                </ItemTemplate>
                <LayoutTemplate>
                    <table runat="server">
                        <tr runat="server">
                            <td runat="server">
                                <table runat="server" id="itemPlaceholderContainer" style="background-color: #FFFFFF; border-collapse: collapse; border-color: #999999; border-style: none; border-width: 1px; font-family: Verdana, Arial, Helvetica, sans-serif;" border="1">
                                    <tr runat="server" style="background-color: #E0FFFF; color: #333333;">
                                        <th runat="server">JobID</th>
                                        <th runat="server">JobDateIn</th>
                                        <th runat="server">JobDateStarted</th>
                                        <th runat="server">JobDateDone</th>
                                        <th runat="server">Name</th>
                                        <th runat="server">ContactPhone</th>
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
                                        <asp:NextPreviousPagerField ButtonType="Button" ShowFirstPageButton="True" ShowNextPageButton="False" ShowPreviousPageButton="False"></asp:NextPreviousPagerField>
                                        <asp:NumericPagerField></asp:NumericPagerField>
                                        <asp:NextPreviousPagerField ButtonType="Button" ShowLastPageButton="True" ShowNextPageButton="False" ShowPreviousPageButton="False"></asp:NextPreviousPagerField>
                                    </Fields>
                                </asp:DataPager>
                            </td>
                        </tr>
                    </table>
                </LayoutTemplate>
                <SelectedItemTemplate>
                    <tr style="background-color: #E2DED6; font-weight: bold; color: #333333;">
                        <td>
                            <asp:Label Text='<%# Eval("JobID") %>' runat="server" ID="JobIDLabel" /></td>
                        <td>
                            <asp:Label Text='<%# Eval("JobDateIn") %>' runat="server" ID="JobDateInLabel" /></td>
                        <td>
                            <asp:Label Text='<%# Eval("JobDateStarted") %>' runat="server" ID="JobDateStartedLabel" /></td>
                        <td>
                            <asp:Label Text='<%# Eval("JobDateDone") %>' runat="server" ID="JobDateDoneLabel" /></td>
                        <td>
                            <asp:Label Text='<%# Eval("Name") %>' runat="server" ID="NameLabel" /></td>
                        <td>
                            <asp:Label Text='<%# Eval("ContactPhone") %>' runat="server" ID="ContactPhoneLabel" /></td>
                    </tr>
                </SelectedItemTemplate>
            </asp:ListView>
        </div>
    </div>
    <%--ODS AREA BELOW--%>
    <asp:ObjectDataSource ID="CurrentJobsListViewODS" runat="server" 
        OldValuesParameterFormatString="original_{0}"
        SelectMethod="JobList" 
        TypeName="eBikeSystem.BLL.JobController"></asp:ObjectDataSource>
</asp:Content>

