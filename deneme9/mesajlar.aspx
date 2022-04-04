<%@ Page Title="" Language="C#" MasterPageFile="~/admin.Master" AutoEventWireup="true" CodeBehind="mesajlar.aspx.cs" Inherits="kurumsal.kurumsaluser.mesajlar" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<section class="content-header">
        <h1>Mesajlar</h1>
        <ol class="breadcrumb">
            <li><a href="#"><i class="fa fa-dashboard"></i>Mesajlar</a></li>
        </ol>
    </section>
    <section class="content">
        <ul class="timeline">
            <!-- timeline time label -->
            <li class="time-label">
                <span class="bg-red">2015
                </span>
            </li>
            <li>
                <!-- timeline icon -->
                <i class="fa fa-envelope bg-blue"></i>
                <asp:Repeater ID="dl_mesaj" runat="server">
                    <ItemTemplate>
                        <div class="timeline-item">
                            <span class="time"><i class="fa fa-clock-o"></i>
                                <asp:Label ID="Label1" runat="server" Text=''></asp:Label></span>
                            <h3 class="timeline-header">
                                <asp:Label ID="Label3" runat="server" Text=''></asp:Label>-
                                <asp:Label ID="Label5" runat="server" Text=''></asp:Label>-
                                <asp:Label ID="Label2" runat="server" Text=''></asp:Label>

                            </h3>
                            <div class="timeline-body">
                                <asp:Label ID="Label4" runat="server" Text=''></asp:Label>
                            </div>
                            <div class='timeline-footer'>
                                <a href='' class="btn btn-primary btn-xs">Sil</a>
                            </div>
                        </div>
                    </ItemTemplate>
                </asp:Repeater>
            </li>
        </ul>
    </section>
</asp:Content>
