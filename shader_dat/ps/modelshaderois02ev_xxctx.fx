sampler Color_1_sampler : register(s0);
float4 CubeParam : register(c42);
sampler ShadowCast_Tex_sampler : register(s10);
sampler Spec_Pow_sampler : register(s4);
float4 ambient_rate : register(c40);
float4 ambient_rate_rate : register(c71);
samplerCUBE cubemap2_sampler : register(s9);
samplerCUBE cubemap_sampler : register(s2);
float3 fog : register(c67);
float4 g_All_Offset : register(c76);
float g_CubeBlendParam : register(c175);
float2 g_ShadowFarInvPs : register(c182);
float g_ShadowUse : register(c180);
float4 g_TargetUvParam : register(c194);
float4 g_specCalc1 : register(c190);
float4 g_specCalc2 : register(c191);
float4 light_Color : register(c61);
float4 lightpos : register(c62);
float4 muzzle_light : register(c69);
float4 muzzle_lightpos : register(c70);
sampler normalmap_sampler : register(s3);
float4 point_light1 : register(c63);
float4 point_light2 : register(c65);
float4 point_lightEv0 : register(c184);
float4 point_lightEv1 : register(c186);
float4 point_lightEv2 : register(c188);
float4 point_lightpos1 : register(c64);
float4 point_lightpos2 : register(c66);
float4 point_lightposEv0 : register(c185);
float4 point_lightposEv1 : register(c187);
float4 point_lightposEv2 : register(c189);
float4 prefogcolor_enhance : register(c77);
float4 specularParam : register(c41);
float4 spot_angle : register(c72);
float4 spot_param : register(c73);
float4 tile : register(c43);
float4x4 viewInverseMatrix : register(c12);

struct PS_IN
{
	float2 texcoord : TEXCOORD;
	float3 texcoord1 : TEXCOORD1;
	float4 texcoord2 : TEXCOORD2;
	float3 texcoord3 : TEXCOORD3;
	float3 texcoord4 : TEXCOORD4;
	float4 texcoord7 : TEXCOORD7;
	float4 texcoord8 : TEXCOORD8;
	float3 texcoord5 : TEXCOORD5;
};

float4 main(PS_IN i) : COLOR
{
	float4 o;

	float4 r0;
	float4 r1;
	float4 r2;
	float4 r3;
	float4 r4;
	float4 r5;
	float4 r6;
	float4 r7;
	float4 r8;
	float4 r9;
	float4 r10;
	float4 r11;
	float4 r12;
	float4 r13;
	float4 r14;
	r0.xy = g_All_Offset.xy + i.texcoord.xy;
	r0 = tex2D(Color_1_sampler, r0);
	r1 = r0.w + -0.01;
	clip(r1);
	r1.x = 1 / i.texcoord7.w;
	r1.xy = r1.xx * i.texcoord7.xy;
	r1.xy = r1.xy * float2(0.5, -0.5) + 0.5;
	r1.xy = r1.xy + g_TargetUvParam.xy;
	r1 = tex2D(ShadowCast_Tex_sampler, r1);
	r1.y = i.texcoord7.z * g_ShadowFarInvPs.y + -g_ShadowFarInvPs.x;
	r1.y = -r1.y + 1;
	r1.x = -r1.x + r1.y;
	r1.x = r1.x + g_ShadowUse.x;
	r1.y = frac(-r1.x);
	r1.x = r1.y + r1.x;
	r1.yzw = muzzle_lightpos.xyz + -i.texcoord1.xyz;
	r2.x = dot(r1.yzw, r1.yzw);
	r2.x = 1 / sqrt(r2.x);
	r2.y = 1 / r2.x;
	r1.yzw = r1.yzw * r2.xxx;
	r2.x = -r2.y + muzzle_lightpos.w;
	r2.x = r2.x * muzzle_light.w;
	r2.yzw = point_lightpos1.xyz + -i.texcoord1.xyz;
	r3.x = dot(r2.yzw, r2.yzw);
	r3.x = 1 / sqrt(r3.x);
	r3.y = 1 / r3.x;
	r3.y = -r3.y + point_lightpos1.w;
	r3.y = r3.y * point_light1.w;
	r4.xyz = r2.yzw * r3.xxx;
	r5.xyz = i.texcoord3.xyz;
	r6.xyz = r5.yzx * i.texcoord2.zxy;
	r5.xyz = i.texcoord2.yzx * r5.zxy + -r6.xyz;
	r6.xy = g_All_Offset.xy;
	r3.zw = i.texcoord.xy * tile.xy + r6.xy;
	r6 = tex2D(normalmap_sampler, r3.zwzw);
	r6.xyz = r6.xyz + -0.5;
	r5.xyz = r5.xyz * -r6.yyy;
	r3.z = r6.x * i.texcoord2.w;
	r5.xyz = r3.zzz * i.texcoord2.xyz + r5.xyz;
	r5.xyz = r6.zzz * i.texcoord3.xyz + r5.xyz;
	r6.xyz = normalize(r5.xyz);
	r3.z = dot(r4.xyz, r6.xyz);
	r4.xyz = r3.zzz * point_light1.xyz;
	r4.xyz = r3.yyy * r4.xyz;
	r5.y = 2;
	r7 = r5.y + -g_specCalc1;
	r4.xyz = r4.xyz * r7.xxx;
	r1.y = dot(r1.yzw, r6.xyz);
	r1.yzw = r1.yyy * muzzle_light.xyz;
	r1.yzw = r1.yzw * r2.xxx + r4.xyz;
	r4.xyz = point_lightpos2.xyz + -i.texcoord1.xyz;
	r2.x = dot(r4.xyz, r4.xyz);
	r2.x = 1 / sqrt(r2.x);
	r3.z = 1 / r2.x;
	r3.z = -r3.z + point_lightpos2.w;
	r3.z = r3.z * point_light2.w;
	r5.xzw = r2.xxx * r4.xyz;
	r3.w = dot(r5.xzw, r6.xyz);
	r5.xzw = r3.www * point_light2.xyz;
	r5.xzw = r3.zzz * r5.xzw;
	r1.yzw = r5.xzw * r7.yyy + r1.yzw;
	r3.w = 1 / spot_angle.w;
	r5.xzw = spot_angle.xyz + -i.texcoord1.xyz;
	r4.w = dot(r5.xzw, r5.xzw);
	r4.w = 1 / sqrt(r4.w);
	r7.x = 1 / r4.w;
	r5.xzw = r4.www * r5.xzw;
	r4.w = dot(r5.xzw, lightpos.xyz);
	r4.w = r4.w + -spot_param.x;
	r3.w = r3.w * r7.x;
	r3.w = -r3.w + 1;
	r3.w = r3.w * 10;
	r5.z = 1;
	r5.x = r5.z + -spot_param.x;
	r5.x = 1 / r5.x;
	r5.x = r4.w * r5.x;
	r5.w = max(r4.w, 0);
	r4.w = 1 / spot_param.y;
	r4.w = r4.w * r5.x;
	r5.x = frac(-r5.w);
	r5.x = r5.x + r5.w;
	r5.w = dot(lightpos.xyz, r6.xyz);
	r7.x = r5.w;
	r5.x = r5.x * r7.x;
	r4.w = r4.w * r5.x;
	r3.w = r3.w * r4.w;
	r4.w = lerp(r3.w, r7.x, spot_param.z);
	r8.xyz = r4.www * light_Color.xyz;
	r3.w = r4.w * 0.5 + 0.5;
	r1.yzw = r8.xyz * r1.xxx + r1.yzw;
	r7.xy = -r0.yy + r0.xz;
	r4.w = max(abs(r7.x), abs(r7.y));
	r4.w = r4.w + -0.015625;
	r5.x = (-r4.w >= 0) ? 0 : 1;
	r4.w = (r4.w >= 0) ? -0 : -1;
	r4.w = r4.w + r5.x;
	r4.w = (r4.w >= 0) ? -r4.w : -0;
	r0.xz = (r4.ww >= 0) ? r0.yy : r0.xz;
	r8.xyz = point_lightposEv0.xyz + -i.texcoord1.xyz;
	r4.w = dot(r8.xyz, r8.xyz);
	r4.w = 1 / sqrt(r4.w);
	r5.x = 1 / r4.w;
	r5.x = -r5.x + point_lightposEv0.w;
	r5.x = r5.x * point_lightEv0.w;
	r0.w = r0.w * prefogcolor_enhance.w;
	o.w = r0.w;
	r9.xyz = r0.xyz * point_lightEv0.xyz;
	r10.xyz = r4.www * r8.xyz;
	r0.w = dot(r10.xyz, r6.xyz);
	r9.xyz = r0.www * r9.xyz;
	r9.xyz = r5.xxx * r9.xyz;
	r7.xyz = r7.zzz * r9.xyz;
	r1.yzw = r0.xyz * r1.yzw + r7.xyz;
	r7.xyz = point_lightposEv1.xyz + -i.texcoord1.xyz;
	r0.w = dot(r7.xyz, r7.xyz);
	r0.w = 1 / sqrt(r0.w);
	r8.w = 1 / r0.w;
	r8.w = -r8.w + point_lightposEv1.w;
	r8.w = r8.w * point_lightEv1.w;
	r9.xyz = r0.xyz * point_lightEv1.xyz;
	r10.xyz = r0.www * r7.xyz;
	r9.w = dot(r10.xyz, r6.xyz);
	r9.xyz = r9.www * r9.xyz;
	r9.xyz = r8.www * r9.xyz;
	r1.yzw = r9.xyz * r7.www + r1.yzw;
	r5.y = r5.y + -g_specCalc2.x;
	r9.xyz = point_lightposEv2.xyz + -i.texcoord1.xyz;
	r7.w = dot(r9.xyz, r9.xyz);
	r7.w = 1 / sqrt(r7.w);
	r9.w = 1 / r7.w;
	r9.w = -r9.w + point_lightposEv2.w;
	r9.w = r9.w * point_lightEv2.w;
	r10.xyz = r0.xyz * point_lightEv2.xyz;
	r11.xyz = r7.www * r9.xyz;
	r10.w = dot(r11.xyz, r6.xyz);
	r10.xyz = r10.www * r10.xyz;
	r10.xyz = r9.www * r10.xyz;
	r1.yzw = r10.xyz * r5.yyy + r1.yzw;
	r5.y = -r1.x + 1;
	r10.xyz = r0.xyz * i.texcoord5.xyz;
	r10.xyz = r5.yyy * r10.xyz;
	r11.xyz = r0.xyz * ambient_rate.xyz;
	r10.xyz = r11.xyz * ambient_rate_rate.xyz + r10.xyz;
	r5.y = dot(lightpos.xyz, i.texcoord3.xyz);
	r5.y = -r5.y + r5.w;
	r5.y = r5.y + 1;
	r1.yzw = r10.xyz * r5.yyy + r1.yzw;
	r10.x = dot(r6.xyz, transpose(viewInverseMatrix)[0].xyz);
	r10.y = dot(r6.xyz, transpose(viewInverseMatrix)[1].xyz);
	r10.z = dot(r6.xyz, transpose(viewInverseMatrix)[2].xyz);
	r5.y = dot(i.texcoord4.xyz, r10.xyz);
	r5.y = r5.y + r5.y;
	r10.xyz = r10.xyz * -r5.yyy + i.texcoord4.xyz;
	r10.w = -r10.z;
	r11 = tex2D(cubemap_sampler, r10.xyww);
	r10 = tex2D(cubemap2_sampler, r10.xyww);
	r12 = lerp(r10, r11, g_CubeBlendParam.x);
	r10 = r12 * ambient_rate_rate.w;
	r10.xyz = r6.www * r10.xyz;
	r10 = r3.w * r10;
	r3.w = r10.w * CubeParam.y + CubeParam.x;
	r10.xyz = r3.www * r10.xyz;
	r11.xyz = r0.xyz * r10.xyz;
	r0.xyz = r0.xyz + specularParam.www;
	r12.xyz = r11.xyz * CubeParam.zzz + r1.yzw;
	r11.xyz = r11.xyz * CubeParam.zzz;
	r1.yzw = r1.yzw * -r11.xyz + r12.xyz;
	r3.w = dot(-i.texcoord1.xyz, -i.texcoord1.xyz);
	r3.w = 1 / sqrt(r3.w);
	r11.xyz = r3.www * -i.texcoord1.xyz;
	r12.xyz = -i.texcoord1.xyz * r3.www + lightpos.xyz;
	r13.xyz = normalize(r12.xyz);
	r3.w = dot(r13.xyz, r6.xyz);
	r2.yzw = r2.yzw * r3.xxx + r11.xyz;
	r12.xyz = normalize(r2.yzw);
	r2.y = dot(r12.xyz, r6.xyz);
	r2.z = -r2.y + 1;
	r12.z = r2.z * -specularParam.z + r2.y;
	r12.yw = specularParam.yy;
	r13 = tex2D(Spec_Pow_sampler, r12.zwzw);
	r2.yzw = r13.xyz * point_light1.xyz;
	r2.yzw = r3.yyy * r2.yzw;
	r2.yzw = r6.www * r2.yzw;
	r13 = g_specCalc1;
	r2.yzw = r2.yzw * r13.xxx;
	r3.x = -r3.w + 1;
	r12.x = r3.x * -specularParam.z + r3.w;
	r12 = tex2D(Spec_Pow_sampler, r12);
	r3.xyw = r12.xyz * light_Color.xyz;
	r3.xyw = r6.www * r3.xyw;
	r2.yzw = r3.xyw * r1.xxx + r2.yzw;
	r3.xyw = r4.xyz * r2.xxx + r11.xyz;
	r4.xyz = normalize(r3.xyw);
	r1.x = dot(r4.xyz, r6.xyz);
	r2.x = -r1.x + 1;
	r12.x = r2.x * -specularParam.z + r1.x;
	r12.yw = specularParam.yy;
	r14 = tex2D(Spec_Pow_sampler, r12);
	r3.xyw = r14.xyz * point_light2.xyz;
	r3.xyz = r3.zzz * r3.xyw;
	r3.xyz = r6.www * r3.xyz;
	r2.xyz = r3.xyz * r13.yyy + r2.yzw;
	r3.xyz = r8.xyz * r4.www + r11.xyz;
	r4.xyz = normalize(r3.xyz);
	r1.x = dot(r4.xyz, r6.xyz);
	r2.w = -r1.x + 1;
	r12.z = r2.w * -specularParam.z + r1.x;
	r3 = tex2D(Spec_Pow_sampler, r12.zwzw);
	r3.xyz = r3.xyz * point_lightEv0.xyz;
	r3.xyz = r5.xxx * r3.xyz;
	r3.xyz = r6.www * r3.xyz;
	r2.xyz = r3.xyz * r13.zzz + r2.xyz;
	r3.xyz = r7.xyz * r0.www + r11.xyz;
	r4.xyz = r9.xyz * r7.www + r11.xyz;
	r7.xyz = normalize(r4.xyz);
	r0.w = dot(r7.xyz, r6.xyz);
	r4.xyz = normalize(r3.xyz);
	r1.x = dot(r4.xyz, r6.xyz);
	r2.w = -r1.x + 1;
	r3.x = r2.w * -specularParam.z + r1.x;
	r3.yw = specularParam.yy;
	r4 = tex2D(Spec_Pow_sampler, r3);
	r4.xyz = r4.xyz * point_lightEv1.xyz;
	r4.xyz = r8.www * r4.xyz;
	r4.xyz = r6.www * r4.xyz;
	r2.xyz = r4.xyz * r13.www + r2.xyz;
	r1.x = -r0.w + 1;
	r3.z = r1.x * -specularParam.z + r0.w;
	r3 = tex2D(Spec_Pow_sampler, r3.zwzw);
	r3.xyz = r3.xyz * point_lightEv2.xyz;
	r3.xyz = r9.www * r3.xyz;
	r3.xyz = r6.www * r3.xyz;
	r0.w = g_specCalc2.x;
	r2.xyz = r3.xyz * r0.www + r2.xyz;
	r0.w = abs(specularParam.x);
	r2.xyz = r0.www * r2.xyz;
	r0.xyz = r2.xyz * r0.xyz + r1.yzw;
	r0.w = r5.z + -CubeParam.z;
	r0.xyz = r10.xyz * r0.www + r0.xyz;
	r1.xyz = fog.xyz;
	r0.xyz = r0.xyz * prefogcolor_enhance.xyz + -r1.xyz;
	o.xyz = i.texcoord8.www * r0.xyz + fog.xyz;

	return o;
}
