using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using eBike.Data.POCOs;
using eBikeSystem.DAL;

namespace eBikeSystem.BLL
{
    [DataObject]
    public class ReceivingController
    {
        [DataObjectMethod(DataObjectMethodType.Select, false)]

        public List<OutstandingOrdersPOCO>GetOutstandingPO()
        {
            using (var context = new eBikeContext())
            { 
                var results = from po in context.PurchaseOrders
                              where po.Closed == false && po.OrderDate.HasValue && po.PurchaseOrderNumber.HasValue
                              select new OutstandingOrdersPOCO
                              {
                                  PurchaseOrderID = po.PurchaseOrderID,
                                  PurchaseOrderNumber = po.PurchaseOrderNumber,
                                  OrderDate = po.OrderDate,
                                  Vendor = po.Vendor.VendorName,
                                  Phone = po.Vendor.Phone
                              };
                return results.ToList();
            }
        } 


    }
}
