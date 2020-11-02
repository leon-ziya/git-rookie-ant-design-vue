<template>
  <a-spin :spinning="confirmLoading">
    <j-form-container :disabled="formDisabled">
      <a-form :form="form" slot="detail">
        <a-row>
          <a-col :span="24">
            <a-form-item label="设备名称" :labelCol="labelCol" :wrapperCol="wrapperCol">
              <a-input v-decorator="['name', validatorRules.name]" placeholder="请输入设备名称"></a-input>
            </a-form-item>
          </a-col>
          <a-col :span="24">
            <a-form-item label="设备类型" :labelCol="labelCol" :wrapperCol="wrapperCol">
              <j-dict-select-tag type="list" v-decorator="['type', validatorRules.type]" :trigger-change="true" dictCode="device_type" placeholder="请选择设备类型"/>
            </a-form-item>
          </a-col>
          <a-col :span="24">
            <a-form-item label="IP地址" :labelCol="labelCol" :wrapperCol="wrapperCol">
              <a-input v-decorator="['ipAddr']" placeholder="请输入IP地址"></a-input>
            </a-form-item>
          </a-col>
          <a-col :span="24">
            <a-form-item label="端口" :labelCol="labelCol" :wrapperCol="wrapperCol">
              <a-input v-decorator="['port', validatorRules.port]" placeholder="请输入端口"></a-input>
            </a-form-item>
          </a-col>
          <a-col :span="24">
            <a-form-item label="连接地址" :labelCol="labelCol" :wrapperCol="wrapperCol">
              <a-input v-decorator="['connectAddr']" placeholder="请输入连接地址"></a-input>
            </a-form-item>
          </a-col>
          <a-col :span="24">
            <a-form-item label="地理位置" :labelCol="labelCol" :wrapperCol="wrapperCol">
              <a-input v-decorator="['address']" placeholder="请输入地理位置"></a-input>
            </a-form-item>
          </a-col>
          <a-col :span="24">
            <a-form-item label="状态" :labelCol="labelCol" :wrapperCol="wrapperCol">
              <j-dict-select-tag type="list" v-decorator="['status']" :trigger-change="true" dictCode="device_status" placeholder="请选择状态"/>
            </a-form-item>
          </a-col>
          <a-col :span="24">
            <a-form-item label="当前显示值" :labelCol="labelCol" :wrapperCol="wrapperCol">
              <a-input v-decorator="['curValue']" placeholder="请输入当前显示值"></a-input>
            </a-form-item>
          </a-col>
          <a-col v-if="showFlowSubmitButton" :span="24" style="text-align: center">
            <a-button @click="submitForm">提 交</a-button>
          </a-col>
        </a-row>
      </a-form>
    </j-form-container>
  </a-spin>
</template>

<script>

  import { httpAction, getAction } from '@/api/manage'
  import pick from 'lodash.pick'
  import { validateDuplicateValue } from '@/utils/util'
  import JFormContainer from '@/components/jeecg/JFormContainer'
  import JDictSelectTag from "@/components/dict/JDictSelectTag"

  export default {
    name: "DeviceRoadSideForm",
    components: {
      JFormContainer,
      JDictSelectTag,
    },
    props: {
      //流程表单data
      formData: {
        type: Object,
        default: ()=>{},
        required: false
      },
      //表单模式：false流程表单 true普通表单
      normal: {
        type: Boolean,
        default: false,
        required: false
      },
      //表单禁用
      disabled: {
        type: Boolean,
        default: false,
        required: false
      }
    },
    data () {
      return {
        form: this.$form.createForm(this),
        model: {},
        labelCol: {
          xs: { span: 24 },
          sm: { span: 5 },
        },
        wrapperCol: {
          xs: { span: 24 },
          sm: { span: 16 },
        },
        confirmLoading: false,
        validatorRules: {
          name: {
            rules: [
              { required: true, message: '请输入设备名称!'},
            ]
          },
          type: {
            rules: [
              { required: true, message: '请输入设备类型!'},
            ]
          },
          port: {
            rules: [
              { required: false},
              { pattern: /^-?\d+$/, message: '请输入整数!'},
            ]
          },
        },
        url: {
          add: "/device/deviceRoadSide/add",
          edit: "/device/deviceRoadSide/edit",
          queryById: "/device/deviceRoadSide/queryById"
        }
      }
    },
    computed: {
      formDisabled(){
        if(this.normal===false){
          if(this.formData.disabled===false){
            return false
          }else{
            return true
          }
        }
        return this.disabled
      },
      showFlowSubmitButton(){
        if(this.normal===false){
          if(this.formData.disabled===false){
            return true
          }else{
            return false
          }
        }else{
          return false
        }
      }
    },
    created () {
      //如果是流程中表单，则需要加载流程表单data
      this.showFlowData();
    },
    methods: {
      add () {
        this.edit({});
      },
      edit (record) {
        this.form.resetFields();
        this.model = Object.assign({}, record);
        this.visible = true;
        this.$nextTick(() => {
          this.form.setFieldsValue(pick(this.model,'name','type','ipAddr','port','connectAddr','address','status','curValue'))
        })
      },
      //渲染流程表单数据
      showFlowData(){
        if(this.normal === false){
          let params = {id:this.formData.dataId};
          getAction(this.url.queryById,params).then((res)=>{
            if(res.success){
              this.edit (res.result);
            }
          });
        }
      },
      submitForm () {
        const that = this;
        // 触发表单验证
        this.form.validateFields((err, values) => {
          if (!err) {
            that.confirmLoading = true;
            let httpurl = '';
            let method = '';
            if(!this.model.id){
              httpurl+=this.url.add;
              method = 'post';
            }else{
              httpurl+=this.url.edit;
               method = 'put';
            }
            let formData = Object.assign(this.model, values);
            console.log("表单提交数据",formData)
            httpAction(httpurl,formData,method).then((res)=>{
              if(res.success){
                that.$message.success(res.message);
                that.$emit('ok');
              }else{
                that.$message.warning(res.message);
              }
            }).finally(() => {
              that.confirmLoading = false;
            })
          }
         
        })
      },
      popupCallback(row){
        this.form.setFieldsValue(pick(row,'name','type','ipAddr','port','connectAddr','address','status','curValue'))
      },
    }
  }
</script>