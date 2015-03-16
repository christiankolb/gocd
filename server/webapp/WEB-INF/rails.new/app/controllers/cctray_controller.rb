##########################GO-LICENSE-START################################
# Copyright 2015 ThoughtWorks, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
##########################GO-LICENSE-END##################################

class CctrayController < ApplicationController
  def index
    if Toggles.isToggleOn(Toggles.NEW_CCTRAY_FEATURE_TOGGLE_KEY)
      render text: cc_tray_service.getCcTrayXml(site_url_prefix)
    else
      doc = cc_tray_status_service.createCctrayXmlDocument(request_context_path)
      render text: com.thoughtworks.go.util.XmlUtils.asXml(doc)
    end
  end

  private
  def site_url_prefix
    server_config_service.siteUrlFor(request_context_path, false)
  end

  def request_context_path
    request.url.sub(request.fullpath, $servlet_context.getContextPath)
  end
end