sampler Color_1_sampler;
sampler Shadow_Tex_sampler;
float4 ambient_rate;
float4 ambient_rate_rate;
float3 fog;
float4 g_All_Offset;
float g_ShadowUse;
float4 g_TargetUvParam;
float4 g_specCalc1;
float4 g_specCalc2;
float4 light_Color;
float4 lightpos;
float4 muzzle_light;
float4 muzzle_lightpos;
float4 point_light1;
float4 point_light2;
float4 point_lightEv0;
float4 point_lightEv1;
float4 point_lightEv2;
float4 point_lightpos1;
float4 point_lightpos2;
float4 point_lightposEv0;
float4 point_lightposEv1;
float4 point_lightposEv2;
float4 prefogcolor_enhance;
float4 specularParam;
float4 spot_angle;
float4 spot_param;

struct PS_IN
{
	float2 texcoord : TEXCOORD;
	float3 texcoord1 : TEXCOORD1;
	float3 texcoord3 : TEXCOORD3;
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
	float3 r7;
	float3 r8;
	r0.xy = g_All_Offset.xy + i.texcoord.xy;
	r0 = tex2D(Color_1_sampler, r0);
	r1 = r0.w + -0.8;
	clip(r1);
	r1.y = 1;
	r0.w = r1.y + -spot_param.x;
	r0.w = 1 / r0.w;
	r1.xyz = spot_angle.xyz + -i.texcoord1.xyz;
	r1.w = dot(r1.xyz, r1.xyz);
	r1.w = 1 / sqrt(r1.w);
	r1.xyz = r1.www * r1.xyz;
	r1.w = 1 / r1.w;
	r1.x = dot(r1.xyz, lightpos.xyz);
	r1.x = r1.x + -spot_param.x;
	r0.w = r0.w * r1.x;
	r2.x = max(r1.x, 0);
	r1.x = 1 / spot_param.y;
	r0.w = r0.w * r1.x;
	r1.x = frac(-r2.x);
	r1.x = r1.x + r2.x;
	r1.y = dot(lightpos.xyz, i.texcoord3.xyz);
	r1.x = r1.x * r1.y;
	r0.w = r0.w * r1.x;
	r1.x = 1 / spot_angle.w;
	r1.x = r1.x * r1.w;
	r1.x = -r1.x + 1;
	r1.x = r1.x * 10;
	r0.w = r0.w * r1.x;
	r2.x = lerp(r0.w, r1.y, spot_param.z);
	r0.w = (-r2.x >= 0) ? 0 : 1;
	r1.x = r2.x * r0.w;
	r1.yzw = r2.xxx * light_Color.xyz;
	r2.xyz = r1.xxx * light_Color.xyz;
	r1.x = dot(-i.texcoord1.xyz, -i.texcoord1.xyz);
	r1.x = 1 / sqrt(r1.x);
	r3.xyz = -i.texcoord1.xyz * r1.xxx + lightpos.xyz;
	r4.xyz = r1.xxx * -i.texcoord1.xyz;
	r5.xyz = normalize(r3.xyz);
	r1.x = dot(r5.xyz, i.texcoord3.xyz);
	r0.w = (-r1.x >= 0) ? 0 : r0.w;
	r2.w = pow(r1.x, specularParam.z);
	r0.w = r0.w * r2.w;
	r2.xyz = r0.www * r2.xyz;
	r0.w = 1 / i.texcoord7.w;
	r3.xy = r0.ww * i.texcoord7.xy;
	r3.xy = r3.xy * float2(0.5, -0.5) + 0.5;
	r3.xy = r3.xy + g_TargetUvParam.xy;
	r3 = tex2D(Shadow_Tex_sampler, r3);
	r0.w = r3.z + g_ShadowUse.x;
	r3.xyz = point_lightpos1.xyz + -i.texcoord1.xyz;
	r1.x = dot(r3.xyz, r3.xyz);
	r1.x = 1 / sqrt(r1.x);
	r5.xyz = r3.xyz * r1.xxx + r4.xyz;
	r3.xyz = r1.xxx * r3.xyz;
	r1.x = 1 / r1.x;
	r1.x = -r1.x + point_lightpos1.w;
	r1.x = r1.x * point_light1.w;
	r2.w = dot(r3.xyz, i.texcoord3.xyz);
	r3.xyz = normalize(r5.xyz);
	r3.x = dot(r3.xyz, i.texcoord3.xyz);
	r3.y = (-r2.w >= 0) ? 0 : 1;
	r3.z = (-r3.x >= 0) ? 0 : r3.y;
	r4.w = pow(r3.x, specularParam.z);
	r3.x = r3.z * r4.w;
	r3.y = r2.w * r3.y;
	r5.xyz = r2.www * point_light1.xyz;
	r5.xyz = r1.xxx * r5.xyz;
	r3.yzw = r3.yyy * point_light1.xyz;
	r3.xyz = r3.xxx * r3.yzw;
	r3.xyz = r1.xxx * r3.xyz;
	r6 = g_specCalc1;
	r3.xyz = r3.xyz * r6.xxx;
	r2.xyz = r2.xyz * r0.www + r3.xyz;
	r3.xyz = point_lightpos2.xyz + -i.texcoord1.xyz;
	r1.x = dot(r3.xyz, r3.xyz);
	r1.x = 1 / sqrt(r1.x);
	r7.xyz = r3.xyz * r1.xxx + r4.xyz;
	r3.xyz = r1.xxx * r3.xyz;
	r1.x = 1 / r1.x;
	r1.x = -r1.x + point_lightpos2.w;
	r1.x = r1.x * point_light2.w;
	r2.w = dot(r3.xyz, i.texcoord3.xyz);
	r3.xyz = normalize(r7.xyz);
	r3.x = dot(r3.xyz, i.texcoord3.xyz);
	r3.y = (-r2.w >= 0) ? 0 : 1;
	r3.z = (-r3.x >= 0) ? 0 : r3.y;
	r4.w = pow(r3.x, specularParam.z);
	r3.x = r3.z * r4.w;
	r3.y = r2.w * r3.y;
	r7.xyz = r2.www * point_light2.xyz;
	r7.xyz = r1.xxx * r7.xyz;
	r3.yzw = r3.yyy * point_light2.xyz;
	r3.xyz = r3.xxx * r3.yzw;
	r3.xyz = r1.xxx * r3.xyz;
	r2.xyz = r3.xyz * r6.yyy + r2.xyz;
	r3.xyz = point_lightposEv0.xyz + -i.texcoord1.xyz;
	r1.x = dot(r3.xyz, r3.xyz);
	r1.x = 1 / sqrt(r1.x);
	r8.xyz = r3.xyz * r1.xxx + r4.xyz;
	r3.xyz = r1.xxx * r3.xyz;
	r1.x = 1 / r1.x;
	r1.x = -r1.x + point_lightposEv0.w;
	r1.x = r1.x * point_lightEv0.w;
	r2.w = dot(r3.xyz, i.texcoord3.xyz);
	r3.xyz = normalize(r8.xyz);
	r3.x = dot(r3.xyz, i.texcoord3.xyz);
	r3.y = (-r2.w >= 0) ? 0 : 1;
	r3.z = (-r3.x >= 0) ? 0 : r3.y;
	r4.w = pow(r3.x, specularParam.z);
	r3.x = r3.z * r4.w;
	r3.y = r2.w * r3.y;
	r3.yzw = r3.yyy * point_lightEv0.xyz;
	r3.xyz = r3.xxx * r3.yzw;
	r3.xyz = r1.xxx * r3.xyz;
	r2.xyz = r3.xyz * r6.zzz + r2.xyz;
	r3.xyz = point_lightposEv1.xyz + -i.texcoord1.xyz;
	r3.w = dot(r3.xyz, r3.xyz);
	r3.w = 1 / sqrt(r3.w);
	r6.xyz = r3.xyz * r3.www + r4.xyz;
	r3.xyz = r3.www * r3.xyz;
	r3.w = 1 / r3.w;
	r3.w = -r3.w + point_lightposEv1.w;
	r3.w = r3.w * point_lightEv1.w;
	r3.x = dot(r3.xyz, i.texcoord3.xyz);
	r8.xyz = normalize(r6.xyz);
	r3.y = dot(r8.xyz, i.texcoord3.xyz);
	r3.z = (-r3.x >= 0) ? 0 : 1;
	r4.w = (-r3.y >= 0) ? 0 : r3.z;
	r5.w = pow(r3.y, specularParam.z);
	r3.y = r4.w * r5.w;
	r3.z = r3.x * r3.z;
	r6.xyz = r3.zzz * point_lightEv1.xyz;
	r6.xyz = r3.yyy * r6.xyz;
	r6.xyz = r3.www * r6.xyz;
	r2.xyz = r6.xyz * r6.www + r2.xyz;
	r6.xyz = point_lightposEv2.xyz + -i.texcoord1.xyz;
	r3.y = dot(r6.xyz, r6.xyz);
	r3.y = 1 / sqrt(r3.y);
	r4.xyz = r6.xyz * r3.yyy + r4.xyz;
	r6.xyz = r3.yyy * r6.xyz;
	r3.y = 1 / r3.y;
	r3.y = -r3.y + point_lightposEv2.w;
	r3.y = r3.y * point_lightEv2.w;
	r3.z = dot(r6.xyz, i.texcoord3.xyz);
	r6.xyz = normalize(r4.xyz);
	r4.x = dot(r6.xyz, i.texcoord3.xyz);
	r4.y = (-r3.z >= 0) ? 0 : 1;
	r4.z = (-r4.x >= 0) ? 0 : r4.y;
	r5.w = pow(r4.x, specularParam.z);
	r4.x = r4.z * r5.w;
	r4.y = r3.z * r4.y;
	r4.yzw = r4.yyy * point_lightEv2.xyz;
	r4.xyz = r4.xxx * r4.yzw;
	r4.xyz = r3.yyy * r4.xyz;
	r4.w = g_specCalc2.x;
	r2.xyz = r4.xyz * r4.www + r2.xyz;
	r4.x = abs(specularParam.x);
	r2.xyz = r2.xyz * r4.xxx;
	r4.y = 2;
	r6 = r4.y + -g_specCalc1;
	r4.xzw = r5.xyz * r6.xxx;
	r5.xyz = muzzle_lightpos.xyz + -i.texcoord1.xyz;
	r5.w = dot(r5.xyz, r5.xyz);
	r5.w = 1 / sqrt(r5.w);
	r5.xyz = r5.www * r5.xyz;
	r5.w = 1 / r5.w;
	r5.w = -r5.w + muzzle_lightpos.w;
	r5.w = r5.w * muzzle_light.w;
	r5.x = dot(r5.xyz, i.texcoord3.xyz);
	r5.xyz = r5.xxx * muzzle_light.xyz;
	r4.xzw = r5.xyz * r5.www + r4.xzw;
	r4.xzw = r7.xyz * r6.yyy + r4.xzw;
	r1.yzw = r1.yzw * r0.www + r4.xzw;
	r0.w = -r0.w + 1;
	r4.xz = -r0.yy + r0.xz;
	r5.x = max(abs(r4.x), abs(r4.z));
	r4.x = r5.x + -0.015625;
	r4.z = (-r4.x >= 0) ? 0 : 1;
	r4.x = (r4.x >= 0) ? -0 : -1;
	r4.x = r4.x + r4.z;
	r4.x = (r4.x >= 0) ? -r4.x : -0;
	r0.xz = (r4.xx >= 0) ? r0.yy : r0.xz;
	r4.xzw = r0.xyz * point_lightEv0.xyz;
	r4.xzw = r2.www * r4.xzw;
	r4.xzw = r1.xxx * r4.xzw;
	r4.xzw = r6.zzz * r4.xzw;
	r1.xyz = r0.xyz * r1.yzw + r4.xzw;
	r4.xzw = r0.xyz * point_lightEv1.xyz;
	r4.xzw = r3.xxx * r4.xzw;
	r4.xzw = r3.www * r4.xzw;
	r1.xyz = r4.xzw * r6.www + r1.xyz;
	r4.xzw = r0.xyz * point_lightEv2.xyz;
	r3.xzw = r3.zzz * r4.xzw;
	r3.xyz = r3.yyy * r3.xzw;
	r1.w = r4.y + -g_specCalc2.x;
	r1.xyz = r3.xyz * r1.www + r1.xyz;
	r3.xyz = r0.xyz * i.texcoord5.xyz;
	r3.xyz = r0.www * r3.xyz;
	r4.xyz = r0.xyz * ambient_rate.xyz;
	r0.xyz = r0.xyz + specularParam.www;
	r3.xyz = r4.xyz * ambient_rate_rate.xyz + r3.xyz;
	r1.xyz = r1.xyz + r3.xyz;
	r0.xyz = r2.xyz * r0.xyz + r1.xyz;
	r1.xyz = fog.xyz;
	r0.xyz = r0.xyz * prefogcolor_enhance.xyz + -r1.xyz;
	o.xyz = i.texcoord8.www * r0.xyz + fog.xyz;
	o.w = prefogcolor_enhance.w;

	return o;
}