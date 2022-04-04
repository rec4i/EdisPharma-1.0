<%@ Page Title="" Language="C#" MasterPageFile="~/admin.Master" AutoEventWireup="true" EnableEventValidation="false" CodeBehind="eczanetakip.aspx.cs" Inherits="kurumsal.kurumsaluser.makaleler" %>

<%@ Register Assembly="CKEditor.NET" Namespace="CKEditor.NET" TagPrefix="CKEditor" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <section class="content-header">
        <h1>Makaleler</h1>
        <ol class="breadcrumb">
            <li><a href="#"><i class="fa fa-dashboard"></i>Makaleler</a></li>
        </ol>
    </section>

    <section class="content">

        <div class="row">
            <div class="col-lg-12">
                <div class="box box-warning box-solid">
                    <div class="box-header with-border">
                        <h3 class="box-title">Eczane Detay</h3>
                        <div class="box-tools pull-right">
                            <button class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i></button>
                        </div>
                        <!-- /.box-tools -->
                    </div>
                    <!-- /.box-header -->
                    <div class="box-body">
                        <div class="form-group">
                            <label id="Label3" runat="server">Eczane ADI</label>
                            <asp:TextBox ID="txt_mbaslik" CssClass="form-control" runat="server"></asp:TextBox>
                        </div>


                        <div class="form-group">
                            <label id="Label2" runat="server">Şehir</label>
                            <asp:DropDownList ID="DropDownListmf" OnSelectedIndexChanged="DropDownListmf_SelectedIndexChanged" AppendDataBoundItems="true" AutoPostBack="true" DataTextField="cityName"
                                DataValueField="cityID" CssClass="form-control" runat="server">
                                <asp:ListItem Value="0">-- Şehir Seç --</asp:ListItem>
                            </asp:DropDownList>
                        </div>
                        <div class="form-group">
                            <label id="Label4" runat="server">Şehir</label>
                            <asp:DropDownList ID="DropDownList1" OnSelectedIndexChanged="DropDownList1_SelectedIndexChanged1" AppendDataBoundItems="true" AutoPostBack="true" DataTextField="TownNAME"
                                DataValueField="TownID" CssClass="form-control" runat="server">
                                <asp:ListItem Value="0">-- Şehir Seç --</asp:ListItem>
                            </asp:DropDownList>
                        </div>

                        <div class="form-group">
                            <label id="Label5" runat="server">Semt</label>
                            <asp:DropDownList ID="DropDownList2" AppendDataBoundItems="true" DataTextField="DistrictName"
                                DataValueField="DistrictID" CssClass="form-control" runat="server">
                                <asp:ListItem Value="0">-- Semt Seç --</asp:ListItem>
                            </asp:DropDownList>
                        </div>
                        <div class="form-group">
                            <label id="Label1" runat="server">İlaç Seç</label>
                            <asp:DropDownList ID="DropDownList3" AppendDataBoundItems="true" DataTextField="UrunADI"
                                DataValueField="UrunID" CssClass="form-control" runat="server">
                                <asp:ListItem Value="0">-- İlaç Seç --</asp:ListItem>
                            </asp:DropDownList>
                        </div>
                        <div class="row">
                        <div class="form-group col-md-12">
                             
                          
                            <asp:RadioButton ID="radioButton1" CssClass="radio col-md-12" runat="server" Text="Stok Adetine Göre Sırala (En az En başta!)" GroupName="productDB"   />
                            <asp:RadioButton ID="radioButton2" CssClass="radio col-md-12" runat="server" Text="Son Ziyaret Tarihine Göre Sırala" GroupName="productDB"   />
                            </div>   
                      </div>
                        <div class="row ">
                            <div class="col-md-12">
                                <div class="form-group">
                                    <asp:Button ID="Button1" runat="server" data-toggle="modal" data-target="#myModal" CssClass="btn-lg btn-block btn-primary" Text="ARA" OnClick="Button1_Click" />

                                </div>
                            </div>



                            <asp:Panel ID="pnl_gdogru" runat="server">
                                <div class="form-group">
                                    <div class="alert alert-success alert-dismissable">
                                        <button type="button" class="close" data-dismiss="alert" aria-hidden="true">×</button>
                                        <h4><i class="icon fa fa-check"></i>Düzenlendi!</h4>
                                        Başarıyla Düzenlendi...
                                    </div>
                                </div>
                            </asp:Panel>
                            <asp:Panel ID="pnl_gyanlis" runat="server">
                                <div class="form-group">
                                    <div class="alert alert-danger alert-dismissable">
                                        <button type="button" class="close" data-dismiss="alert" aria-hidden="true">×</button>
                                        <h4><i class="icon fa fa-ban"></i>Hata!</h4>
                                        Bir Sorun Çıktı Boşlukları Doldurun Lütfen...
                                    </div>
                                </div>
                            </asp:Panel>
                        </div>
                        <!-- /.box-body -->
                    </div>
                    <!-- /.box -->
                </div>
            </div>
            <div id="EczaneDetayRow" runat="server" class="row">
                <div class="col-lg-12">
                    <div id="EczaneBilgiDiv" runat="server" cssclass="" class="box box-default collapsed-box box-solid">
                        <div class="box-header with-border">
                            <h3 class="box-title"></h3>

                            <div class="box-tools pull-right">
                                <button type="button" class="btn btn-box-tool" data-widget="collapse">
                                    <i class="fa fa-plus"></i>
                                </button>
                            </div>
                            <!-- /.box-tools -->
                        </div>
                        <!-- /.box-header -->
                        <div class="box-body">
                            <div class="box">
                                <div class="box-body table-responsive no-padding">
                                    <table class="table table-hover">
                                        <tbody>
                                            <tr>

                                                <th>EczaneID</th>
                                                <th>Eczane ADI</th>
                                                
                                                
                                                
                                                
                                                <th>S.Ziyaret Tarihi</th>
                                                <th>Geçen Gün</th>
                                                <th>İncele</th>
                                            </tr>


                                            <asp:Repeater ID="RepeaterSiparisOnayDurum" runat="server">
                                                <ItemTemplate>
                                                    <tr>
                                                        <th><%# Eval("EczaneID") %></th>
                                                        <th><%# Eval("Eczane_ADI") %></th>
                                                       
                                                        
                                                        
                                                        
                                                        <th><%# Eval("Sonziyarettar","{0:dd MMMM yyyy}") %></th>
                                                        <th><span class=' <%# KalanGunHesapla(Convert.ToInt32(KalanGunHesapla(Convert.ToDateTime(Eval("Sonziyarettar"))))) %> '>Geçen Gün <%#KalanGunHesapla(Convert.ToDateTime(Eval("Sonziyarettar"))) %></span></th>
                                                        <td><a href='eczanedetay.aspx?EczaneID=<%#Eval("EczaneID") %>'><i class="fa fa fa-search"></i></a></td>

                                                    </tr>
                                                </ItemTemplate>
                                            </asp:Repeater>
                                        </tbody>
                                    </table>
                                </div>
                                <!-- /.box-body -->
                            </div>
                            <!-- /.box -->
                        </div>
                        <!-- /.box-body -->
                    </div>
                    <!-- /.box -->
                </div>
            </div>
        </div>
    </section>
</asp:Content>
