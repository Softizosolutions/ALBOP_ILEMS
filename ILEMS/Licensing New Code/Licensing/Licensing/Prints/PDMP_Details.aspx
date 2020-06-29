<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PDMP_Details.aspx.cs" Inherits="Licensing.Prints.PDMP_Details" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="../Styles/product.css" rel="stylesheet" />
    <style>
        tr {
            height:28px;
            page-break-inside: avoid !important;
        }
        .newpg {
            page-break-before:always;
        }
    </style>
</head>
<body>
    <style>
        td{
            page-break-inside:avoid !important;
        }
        tr{
            page-break-inside:avoid !important;
        }
    </style>
    <form id="form1" runat="server">
   <center>
       <asp:GridView ID="grdpdmp" runat="server" AllowPaging="false" Width="95%" AutoGenerateColumns="false" CssClass="gridmain">
         <AlternatingRowStyle CssClass="grdalt" />
        <RowStyle CssClass="grditem" />
        <HeaderStyle CssClass="grdheadbg" />
           <Columns>
               <asp:TemplateField HeaderText="License #">
                   <ItemTemplate>
                       <asp:Label ID="lbllicense" runat="server" Text='<%#Eval("Lic_no").ToString() %>'></asp:Label>
                   </ItemTemplate>
               </asp:TemplateField>
               <asp:TemplateField HeaderText="Business">
                 <ItemTemplate>
                     <asp:Label ID="lblbusiness" runat="server" Text='<%#Eval("Business").ToString() %>'></asp:Label>
                 </ItemTemplate>
               </asp:TemplateField>
               <asp:TemplateField HeaderText="DEA">
                   <ItemTemplate>
                       <asp:Label ID="lbldea" runat="server" Text='<%#Eval("DEA").ToString() %>'></asp:Label>
                   </ItemTemplate>
               </asp:TemplateField>
               <asp:TemplateField HeaderText="Address1">
                   <ItemTemplate>
                       <asp:Label ID="lbladdress1" runat="server" Text='<%#Eval("Address1").ToString() %>'></asp:Label>
                   </ItemTemplate>
               </asp:TemplateField>
                <asp:TemplateField HeaderText="Address2">
                   <ItemTemplate>
                       <asp:Label ID="lbladdress2" runat="server" Text='<%#Eval("Address2").ToString() %>'></asp:Label>
                   </ItemTemplate>
               </asp:TemplateField>
                <asp:TemplateField HeaderText="City">
                   <ItemTemplate>
                       <asp:Label ID="lblcity" runat="server" Text='<%#Eval("City").ToString() %>'></asp:Label>
                   </ItemTemplate>
               </asp:TemplateField>
                <asp:TemplateField HeaderText="State">
                   <ItemTemplate>
                       <asp:Label ID="lblstate" runat="server" Text='<%#Eval("State").ToString() %>'></asp:Label>
                   </ItemTemplate>
               </asp:TemplateField>
                <asp:TemplateField HeaderText="Zip">
                   <ItemTemplate>
                       <asp:Label ID="lblzip" runat="server" Text='<%#Eval("Zip").ToString() %>'></asp:Label>
                   </ItemTemplate>
               </asp:TemplateField>
               <asp:TemplateField HeaderText="Monday Friday">
                   <ItemTemplate>
                       <asp:Label ID="lblday" runat="server" Text='<%#Eval("Monday_Friday").ToString() %>'></asp:Label>
                   </ItemTemplate>
               </asp:TemplateField>
               <asp:TemplateField HeaderText="Saturday">
                   <ItemTemplate>
                       <asp:Label ID="lblsat" runat="server" Text='<%#Eval("Saturday").ToString() %>'></asp:Label>
                   </ItemTemplate>
               </asp:TemplateField>
               <asp:TemplateField HeaderText="Sunday">
                   <ItemTemplate>
                       <asp:Label ID="lblsun" runat="server" Text='<%#Eval("Sunday").ToString() %>'></asp:Label>
                       <%# Chknewpg() %>
                   </ItemTemplate>
               </asp:TemplateField>
           </Columns>
       </asp:GridView>
   </center>
    </form>
</body>
</html>
