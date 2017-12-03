using eBike.Data.Entities;
using eBike.Data.POCOs;
using eBikeSystem.DAL;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eBikeSystem.BLL
{
    [DataObject]
    public class PurchasingController
    {
        [DataObjectMethod(DataObjectMethodType.Select, false)]
        public List<VendorListPOCO> VendorList(string vendorname, string vendorcity, string vendorphone)
        {
            using (var context = new eBikeContext())
            {
                var results = (from x in context.Vendors
                              select new VendorListPOCO
                              {
                                    VendorID = x.VendorID,
                                    VendorName = x.VendorName,
                                    City = x.City,
                                    Phone = x.Phone
                              }).OrderBy(z => z.VendorName);
                return results.ToList();
            }
        }

        [DataObjectMethod(DataObjectMethodType.Select, false)]
        public List<PurchaseOrderPartsPOCO> PurchaseOrderPartsList()
        {
            using (var context = new eBikeContext())
            {
                var results = (from x in context.Parts
                              select new PurchaseOrderPartsPOCO
                              {
                                  PartID = x.PartID,
                                  Description = x.Description,
                                  QuantityOnHand = x.QuantityOnHand,
                                  QuantityOnOrder = x.QuantityOnOrder,
                                  ReorderLevel = x.ReorderLevel,
                                  Buffer = (x.QuantityOnHand + x.QuantityOnOrder) - x.ReorderLevel,
                                  PurchasePrice = x.PurchasePrice
                              }).Distinct().OrderBy(z => z.PartID);
                return results.ToList();
            }
        }

        public void GetOrCreatePO(int purchaseordernumber, DateTime orderdate)
        {
            using (var context = new eBikeContext())
            {
                var activeorder = (from x in context.PurchaseOrders
                                where x.PurchaseOrderNumber == null && x.OrderDate == null
                                   select x).FirstOrDefault();


        }
        }
    }
}
