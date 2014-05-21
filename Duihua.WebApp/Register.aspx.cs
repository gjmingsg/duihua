﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Duihua.Lib.Services;
using Duihua.Lib.Common;

namespace Duihua.WebApp
{
    public partial class Register : System.Web.UI.Page
    {
        private readonly RegisterService r = new RegisterService();
        private readonly ClassService c = new ClassService();
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void ddClassID_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (string.IsNullOrEmpty(ddClassID.SelectedValue) == false)
            {
                var item = c.GetClass(ddClassID.SelectedValue);
                if (item == null)
                    return;
                lbClassInfo.Text = item["Intro"].ToString();
            }
            else {
                lbClassInfo.Text = "";
            }
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            if (string.IsNullOrEmpty(tbRegisterNo.Text))
            {
                int count = r.GetRegisterCount(null, null, null);
                tbRegisterNo.Text = string.Format("{0:yyyyMMddHHmmss}",DateTime.Now) + string.Format("%05i",count);
                dsRegister.Insert();
                lblRegisterNo.Visible = true;
            }
            else
                dsRegister.Update();
        }

        protected void CustomValidator1_ServerValidate(object source, ServerValidateEventArgs args)
        {
            string validateCode = Session["CheckStr"].ToString();
            if (tbValidateCode.Text.Equals(validateCode))
                args.IsValid = true;
            else
                args.IsValid = false;
        }

        protected void cvRegistName_ServerValidate(object source, ServerValidateEventArgs args)
        {
            if (args.Value.Length >= 50)
            {
                args.IsValid = false;
            }
            else {
                args.IsValid = true;
            }
        }

        protected void lbCheckRegister_Click(object sender, EventArgs e)
        {
            lblRegisterNo.Visible = true;
            var obj = sender as LinkButton;
            if ("check".Equals(obj.CommandName)) {
                obj.CommandName = "load";
                obj.Text = "查询";
                tbRegisterNo.ReadOnly = false;
            }
            else {
                obj.CommandName = "check";
                obj.Text = "查看之前的报名信息";
                var item = r.GetRegister(tbRegisterNo.Text);
                tbRegisterNo.ReadOnly = true;
                WebHelper.Fill(FRegisterInfo, item);
            }
        }

        protected void cvRegisterNo_ServerValidate(object source, ServerValidateEventArgs args)
        {
            if (tbRegisterNo.ReadOnly)
                args.IsValid = true;
            else if (string.IsNullOrEmpty(tbRegisterNo.Text))
                args.IsValid = false;
            else
                args.IsValid = true;
        }
    }
}