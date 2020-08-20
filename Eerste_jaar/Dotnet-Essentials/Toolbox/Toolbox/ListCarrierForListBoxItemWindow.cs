using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Toolbox
{
    public class ListCarrierForListBoxItemWindow
    {
        private string _parentListName;

        public string ParentListName
        {
            get { return _parentListName; }
            set { _parentListName = value; }
        }

        private List<string> _carriedList;

        public List<string> CarriedList
        {
            get { return _carriedList; }
            set { _carriedList = value; }
        }

        public ListCarrierForListBoxItemWindow(string parentListName, List<string> carriedList)
        {
            _parentListName = parentListName;
            _carriedList = carriedList;
        }

        public override string ToString()
        {
            return ParentListName;
        }
    }
}
