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
        public List<VendorListPOCO> VendorList()
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
        public List<PurchaseOrderPartsPOCO> ActivePurchaseOrder_ByVendor(int vendorid)
        {
            using (var context = new eBikeContext())
            {
                var activeorder = (from x in context.PurchaseOrders
                                   where x.VendorID == vendorid && x.PurchaseOrderNumber == null && x.OrderDate == null
                                   select x.PurchaseOrderID).FirstOrDefault();

                var results = (from x in context.PurchaseOrderDetails
                               where x.PurchaseOrderID == activeorder
                               select new PurchaseOrderPartsPOCO
                              {
                                  PartID = x.PartID,
                                  Description = x.Part.Description,
                                  QuantityOnHand = x.Part.QuantityOnHand,
                                  QuantityOnOrder = x.Part.QuantityOnOrder,
                                  ReorderLevel = x.Part.ReorderLevel,
                                  Quantity = x.Quantity,
                                  PurchasePrice = x.PurchasePrice
                              }).OrderBy(z => z.PartID);
                return results.ToList();
            }
        }

        [DataObjectMethod(DataObjectMethodType.Select, false)]
        public List<PurchaseOrderPartsPOCO> SuggestedPurchaseOrder_ByVendor(int vendorid)
        {
            using (var context = new eBikeContext())
            {
                //var suggestedorder = (from x in context.PurchaseOrders
                //                   where x.VendorID == vendorid
                //                   select x.PurchaseOrderID).FirstOrDefault();

                var buffer = (from x in context.Parts
                             where x.VendorID == vendorid && x.ReorderLevel - (x.QuantityOnHand + x.QuantityOnOrder) > 0
                             select x.PartID).ToList();

                var results = (from x in context.PurchaseOrderDetails
                               where x.Part.VendorID == vendorid && buffer.Contains(x.Part.PartID)
                               select new PurchaseOrderPartsPOCO
                               {
                                   PartID = x.Part.PartID,
                                   Description = x.Part.Description,
                                   QuantityOnHand = x.Part.QuantityOnHand,
                                   QuantityOnOrder = x.Part.QuantityOnOrder,
                                   ReorderLevel = x.Part.ReorderLevel,
                                   Quantity = x.Quantity,
                                   PurchasePrice = x.PurchasePrice
                               }).OrderBy(z => z.PartID);
                return results.ToList();
            }
        }

        [DataObjectMethod(DataObjectMethodType.Select, false)]
        public List<PurchaseOrderPartsPOCO> PartsInventory_ByVendor(int vendorid)
        {
            using (var context = new eBikeContext())
            {
                var activeorder = (from x in context.PurchaseOrders
                                   where x.VendorID == vendorid && x.PurchaseOrderNumber == null && x.OrderDate == null
                                   select x.PurchaseOrderID).FirstOrDefault();

                var activeorderparts = from x in context.PurchaseOrderDetails
                                       where x.PurchaseOrderID == activeorder
                                       select x.PartID;

                var results = (from x in context.Parts
                               where x.VendorID == vendorid && !activeorderparts.Contains(x.PartID)
                               select new PurchaseOrderPartsPOCO
                               {
                                   PartID = x.PartID,
                                   Description = x.Description,
                                   QuantityOnHand = x.QuantityOnHand,
                                   QuantityOnOrder = x.QuantityOnOrder,
                                   ReorderLevel = x.ReorderLevel,
                                   Buffer = x.ReorderLevel - (x.QuantityOnHand + x.QuantityOnOrder),
                                   PurchasePrice = x.PurchasePrice
                               }).OrderBy(z => z.PartID);
                return results.ToList();
            }
        }
    }
}
