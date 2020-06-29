using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Data.Linq;
using System.Linq;
using System.Web;
//using System.Web.Security;
//using System.Web.UI;
//using System.Web.UI.HtmlControls;
//using System.Web.UI.WebControls;
//using System.Web.UI.WebControls.WebParts;
using System.Text;
using System.Collections.Generic;
 
using System.Data.SqlClient;




namespace Accounting_Data
{
    public static class Accounting_Details
    {

        #region Batch Details

        public static List<USP_Accounting_GetFinancialBatchResultsResult> GetFinancialAccountBatchResults(string user, string batchno, string recno, string batchstatus, string creditedfrom, string creditedto)
        {
            using (DataClasses1DataContext db=new DataClasses1DataContext ())
           {
                


                return db.USP_Accounting_GetFinancialBatchResults(user, batchno, recno, batchstatus, creditedfrom, creditedto).ToList();
           }
            
        }

        public static List<USP_Accounting_GetFinancialBatchTransforBatchNoResultsResult> GetFinancialAccountBatchTransforBatchNoResults(string batchno)
        {
            using (DataClasses1DataContext db = new DataClasses1DataContext())
            {
                
                return db.USP_Accounting_GetFinancialBatchTransforBatchNoResults(batchno).ToList();
            }

        }

      


     
     
        #endregion
        #region Consumer Invoice

        public static List<TBL_Accounting_ConsumerInvoice> Get_ConsumerInvoice_GridData()
        {
            using (DataClasses1DataContext db = new DataClasses1DataContext())
            {
                return db.TBL_Accounting_ConsumerInvoices.ToList();

            }
        }
        public static List<tbl_lkp_subobj> RetriveAmountSubOrg(int subobjid)
        {

            using (DataClasses1DataContext db = new DataClasses1DataContext())
            {
                return db.tbl_lkp_subobjs.Where(c => c.Subobj_Id == subobjid).ToList();
            }
        }

        public static int Insert_ConsumerInvoice(TBL_Accounting_ConsumerInvoice tblinvoice)
        {
            using (DataClasses1DataContext dbinsert=new DataClasses1DataContext ())
            {
                int? latid = 0;

              dbinsert.USP_Accounting_ConsumerInvoice(101, tblinvoice.Cons_Invoice_Id, tblinvoice.Billto, tblinvoice.Address1, tblinvoice.Address2, tblinvoice.City, tblinvoice.State, tblinvoice.Zip, ref latid, tblinvoice.Indicator);
              int i =Convert.ToInt32(latid);
                
              return i;
                //dbinsert.SubmitChanges();                 
            }
        }



        public static void Insert_ConsumerInvoiceFeeData(TBL_Accounting_Consumer_InvoiceFee tbl_invoicefee)
        {
            using (DataClasses1DataContext db = new DataClasses1DataContext())
            {
                db.USP_Accounting_ConsumerInvoice_Fees(101, 0, tbl_invoicefee.Cons_Invoice_Id,tbl_invoicefee.FeeTypeId.ToString(), tbl_invoicefee.Amount.ToString(), tbl_invoicefee.DueDate.ToString());
                db.SubmitChanges();

            }

        }
        #endregion
        #region Accounting Details

        public static List<tbl_lkp_table> Get_Lkp_tables()
        {
            using (DataClasses1DataContext db = new DataClasses1DataContext())
            {
                return db.tbl_lkp_tables.OrderBy(c => c.Lkp_table_name).ToList();
            }
        }
        public static List<tbl_lkp_data> Get_Lkp_tablesdata(int tbllkpid)
        {
            using (DataClasses1DataContext db = new DataClasses1DataContext())
            {
                return db.tbl_lkp_datas.Where(c => c.Lkp_tbl_ID == tbllkpid).OrderBy(c=>c.Values).ToList();
            }
        }


        #endregion
        #region master values
        public static int Save_Mastervaues(int dataid, int tableid, int orgid, string value)
        {
            using (DataClasses1DataContext db = new DataClasses1DataContext())
            {
                tbl_lkp_data obj_tbl_lkp_data;
                if (dataid == 0)
                    obj_tbl_lkp_data = new tbl_lkp_data();
                else
                    obj_tbl_lkp_data = db.tbl_lkp_datas.Where(c => c.Lkp_data_ID == dataid).SingleOrDefault();
                obj_tbl_lkp_data.Lkp_tbl_ID = tableid;
                obj_tbl_lkp_data.Org_ID = orgid;
                obj_tbl_lkp_data.Values = value;

                if (dataid == 0)
                    db.tbl_lkp_datas.InsertOnSubmit(obj_tbl_lkp_data);

                db.SubmitChanges();
                return obj_tbl_lkp_data.Lkp_data_ID;
            }
        }
        public static void Delee_Mastervalues(int dataid)
        {
            using (DataClasses1DataContext db = new DataClasses1DataContext())
            {
                tbl_lkp_data obj = db.tbl_lkp_datas.Where(c => c.Lkp_data_ID == dataid).SingleOrDefault();
                db.tbl_lkp_datas.DeleteOnSubmit(obj);
                db.SubmitChanges();
            }
        }
        public static List<tbl_lkp_data> Get_Masters(int tbl_id)
        {
            using (DataClasses1DataContext db = new DataClasses1DataContext())
            {
                return db.tbl_lkp_datas.Where(c => c.Lkp_tbl_ID == tbl_id).ToList();
            }
        }
        public static tbl_lkp_data Get_valuebyid(int dataid)
        {
            using (DataClasses1DataContext db = new DataClasses1DataContext())
            {
                return db.tbl_lkp_datas.Where(c => c.Lkp_data_ID == dataid).SingleOrDefault();
            }
        }
        #endregion
        #region Masters LookUp Data Code


        public static List<tbl_lkp_data> Get_lkp_Tabledata(int IdNumber)
        {
            using (DataClasses1DataContext plkpcounty = new DataClasses1DataContext())
            {
                return plkpcounty.tbl_lkp_datas.Where(c => c.Lkp_tbl_ID == IdNumber).ToList();
            }
        }


        #endregion
        #region  ConsumerInvoice_Pdfgeneration
        public static List<usp_consumerInvoicerptResult> Get_ConsumerInvoice_PdfBind(string InvoiceId)
        {
            using (DataClasses1DataContext db = new DataClasses1DataContext())
            {
                return db.usp_consumerInvoicerpt(InvoiceId).ToList();

            }
        }
       
        #endregion

        public static int? flag { get; set; }

        #region New Fee Insertion and Binding
        public static List<tbl_lkp_subobj> NewFee_Bind()
        {

            using (DataClasses1DataContext db = new DataClasses1DataContext())
            {
                return db.tbl_lkp_subobjs.ToList();
            }
        }
        public static int Insert_Subobjdata(int subobjid, string subobjcode, string Desc, string amount, string fullDesc,string objtype)
        {
            using (DataClasses1DataContext subobjdatainsert = new DataClasses1DataContext())
            {
                tbl_lkp_subobj subobj;
                if (subobjid == 0)
                    subobj = new tbl_lkp_subobj();
                else
                    subobj = subobjdatainsert.tbl_lkp_subobjs.Where(c => c.Subobj_Id == subobjid).SingleOrDefault();
                subobj.Subobj_code = subobjcode;
                subobj.Description = Desc;
                subobj.Amount =Convert.ToDecimal( amount);
                subobj.Full_Description = fullDesc;
                subobj.Rev_obj_Id =Convert.ToInt32( objtype);
                if (subobjid == 0)
                    subobjdatainsert.tbl_lkp_subobjs.InsertOnSubmit(subobj);
                subobjdatainsert.SubmitChanges();
                return subobj.Subobj_Id;

            }
        }
        public static tbl_lkp_subobj Edit_SubObj(int subobjid)
        {
            using (DataClasses1DataContext pd = new DataClasses1DataContext())
            {
                return pd.tbl_lkp_subobjs.Where(c => c.Subobj_Id == subobjid).SingleOrDefault();
            }
        }
        public static void DeleteSubobj(int subobjid)
        {
            using (DataClasses1DataContext pd = new DataClasses1DataContext())
            {
                tbl_lkp_subobj obj = pd.tbl_lkp_subobjs.Where(c => c.Subobj_Id == subobjid).SingleOrDefault();
                pd.tbl_lkp_subobjs.DeleteOnSubmit(obj);
                pd.SubmitChanges();

            }
        }
        #endregion
    }
}
