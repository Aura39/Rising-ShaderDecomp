sampler Color_1_sampler : register(s0);
float4 CubeParam : register(c42);
sampler ShadowCast_Tex_sampler : register(s10);
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
sampler tripleMask_sampler : register(s1);

struct PS_IN
{
	float2 texcoord : TEXCOORD;
	float3 texcoord1 : TEXCOORD1;
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
	float3 r8;
	float3 r9;
	float3 r10;
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
	r1.z = 1;
	r1.y = r1.z + -spot_param.x;
	r1.y = 1 / r1.y;
	r2.xyz = spot_angle.xyz + -i.texcoord1.xyz;
	r1.w = dot(r2.xyz, r2.xyz);
	r1.w = 1 / sqrt(r1.w);
	r2.xyz = r1.www * r2.xyz;
	r1.w = 1 / r1.w;
	r2.x = dot(r2.xyz, lightpos.xyz);
	r2.x = r2.x + -spot_param.x;
	r1.y = r1.y * r2.x;
	r3.x = max(r2.x, 0);
	r2.x = 1 / spot_param.y;
	r1.y = r1.y * r2.x;
	r2.x = frac(-r3.x);
	r2.x = r2.x + r3.x;
	r2.y = dot(lightpos.xyz, i.texcoord3.xyz);
	r2.x = r2.x * r2.y;
	r1.y = r1.y * r2.x;
	r2.x = 1 / spot_angle.w;
	r1.w = r1.w * r2.x;
	r1.w = -r1.w + 1;
	r1.w = r1.w * 10;
	r1.y = r1.w * r1.y;
	r3.x = lerp(r1.y, r2.y, spot_param.z);
	r1.y = (-r3.x >= 0) ? 0 : 1;
	r1.w = r3.x * r1.y;
	r2.xyz = r1.www * light_Color.xyz;
	r1.w = dot(-i.texcoord1.xyz, -i.texcoord1.xyz);
	r1.w = 1 / sqrt(r1.w);
	r3.yzw = -i.texcoord1.xyz * r1.www + lightpos.xyz;
	r4.xyz = r1.www * -i.texcoord1.xyz;
	r5.xyz = normalize(r3.yzw);
	r1.w = dot(r5.xyz, i.texcoord3.xyz);
	r1.y = (-r1.w >= 0) ? 0 : r1.y;
	r2.w = pow(r1.w, specularParam.z);
	r1.y = r1.y * r2.w;
	r2.xyz = r1.yyy * r2.xyz;
	r1.yw = tile.xy * i.texcoord.xy;
	r5 = tex2D(tripleMask_sampler, r1.ywzw);
	r2.xyz = r2.xyz * r5.zzz;
	r3.yzw = point_lightpos1.xyz + -i.texcoord1.xyz;
	r1.y = dot(r3.yzw, r3.yzw);
	r1.y = 1 / sqrt(r1.y);
	r6.xyz = r3.yzw * r1.yyy + r4.xyz;
	r3.yzw = r1.yyy * r3.yzw;
	r1.y = 1 / r1.y;
	r1.y = -r1.y + point_lightpos1.w;
	r1.y = r1.y * point_light1.w;
	r1.w = dot(r3.yzw, i.texcoord3.xyz);
	r7.xyz = normalize(r6.xyz);
	r2.w = dot(r7.xyz, i.texcoord3.xyz);
	r3.y = (-r1.w >= 0) ? 0 : 1;
	r3.z = (-r2.w >= 0) ? 0 : r3.y;
	r3.w = pow(r2.w, specularParam.z);
	r2.w = r3.w * r3.z;
	r3.y = r1.w * r3.y;
	r6.xyz = r1.www * point_light1.xyz;
	r6.xyz = r1.yyy * r6.xyz;
	r3.yzw = r3.yyy * point_light1.xyz;
	r3.yzw = r2.www * r3.yzw;
	r3.yzw = r5.zzz * r3.yzw;
	r3.yzw = r1.yyy * r3.yzw;
	r7 = g_specCalc1;
	r3.yzw = r3.yzw * r7.xxx;
	r2.xyz = r2.xyz * r1.xxx + r3.yzw;
	r3.yzw = point_lightpos2.xyz + -i.texcoord1.xyz;
	r1.y = dot(r3.yzw, r3.yzw);
	r1.y = 1 / sqrt(r1.y);
	r8.xyz = r3.yzw * r1.yyy + r4.xyz;
	r3.yzw = r1.yyy * r3.yzw;
	r1.y = 1 / r1.y;
	r1.y = -r1.y + point_lightpos2.w;
	r1.y = r1.y * point_light2.w;
	r1.w = dot(r3.yzw, i.texcoord3.xyz);
	r9.xyz = normalize(r8.xyz);
	r2.w = dot(r9.xyz, i.texcoord3.xyz);
	r3.y = (-r1.w >= 0) ? 0 : 1;
	r3.z = (-r2.w >= 0) ? 0 : r3.y;
	r3.w = pow(r2.w, specularParam.z);
	r2.w = r3.w * r3.z;
	r3.y = r1.w * r3.y;
	r8.xyz = r1.www * point_light2.xyz;
	r8.xyz = r1.yyy * r8.xyz;
	r3.yzw = r3.yyy * point_light2.xyz;
	r3.yzw = r2.www * r3.yzw;
	r3.yzw = r5.zzz * r3.yzw;
	r3.yzw = r1.yyy * r3.yzw;
	r2.xyz = r3.yzw * r7.yyy + r2.xyz;
	r3.yzw = point_lightposEv0.xyz + -i.texcoord1.xyz;
	r1.y = dot(r3.yzw, r3.yzw);
	r1.y = 1 / sqrt(r1.y);
	r9.xyz = r3.yzw * r1.yyy + r4.xyz;
	r3.yzw = r1.yyy * r3.yzw;
	r1.y = 1 / r1.y;
	r1.y = -r1.y + point_lightposEv0.w;
	r1.y = r1.y * point_lightEv0.w;
	r1.w = dot(r3.yzw, i.texcoord3.xyz);
	r10.xyz = normalize(r9.xyz);
	r2.w = dot(r10.xyz, i.texcoord3.xyz);
	r3.y = (-r1.w >= 0) ? 0 : 1;
	r3.z = (-r2.w >= 0) ? 0 : r3.y;
	r3.w = pow(r2.w, specularParam.z);
	r2.w = r3.w * r3.z;
	r3.y = r1.w * r3.y;
	r3.yzw = r3.yyy * point_lightEv0.xyz;
	r3.yzw = r2.www * r3.yzw;
	r3.yzw = r5.zzz * r3.yzw;
	r3.yzw = r1.yyy * r3.yzw;
	r2.xyz = r3.yzw * r7.zzz + r2.xyz;
	r3.yzw = point_lightposEv1.xyz + -i.texcoord1.xyz;
	r2.w = dot(r3.yzw, r3.yzw);
	r2.w = 1 / sqrt(r2.w);
	r7.xyz = r3.yzw * r2.www + r4.xyz;
	r3.yzw = r2.www * r3.yzw;
	r2.w = 1 / r2.w;
	r2.w = -r2.w + point_lightposEv1.w;
	r2.w = r2.w * point_lightEv1.w;
	r3.y = dot(r3.yzw, i.texcoord3.xyz);
	r9.xyz = normalize(r7.xyz);
	r3.z = dot(r9.xyz, i.texcoord3.xyz);
	r3.w = (-r3.y >= 0) ? 0 : 1;
	r4.w = (-r3.z >= 0) ? 0 : r3.w;
	r5.x = pow(r3.z, specularParam.z);
	r3.z = r4.w * r5.x;
	r3.w = r3.y * r3.w;
	r7.xyz = r3.www * point_lightEv1.xyz;
	r7.xyz = r3.zzz * r7.xyz;
	r7.xyz = r5.zzz * r7.xyz;
	r7.xyz = r2.www * r7.xyz;
	r2.xyz = r7.xyz * r7.www + r2.xyz;
	r3.z = g_specCalc2.x;
	r7.xyz = point_lightposEv2.xyz + -i.texcoord1.xyz;
	r3.w = dot(r7.xyz, r7.xyz);
	r3.w = 1 / sqrt(r3.w);
	r4.xyz = r7.xyz * r3.www + r4.xyz;
	r7.xyz = r3.www * r7.xyz;
	r3.w = 1 / r3.w;
	r3.w = -r3.w + point_lightposEv2.w;
	r3.w = r3.w * point_lightEv2.w;
	r4.w = dot(r7.xyz, i.texcoord3.xyz);
	r7.xyz = normalize(r4.xyz);
	r4.x = dot(r7.xyz, i.texcoord3.xyz);
	r4.y = (-r4.w >= 0) ? 0 : 1;
	r4.z = (-r4.x >= 0) ? 0 : r4.y;
	r5.x = pow(r4.x, specularParam.z);
	r4.x = r4.z * r5.x;
	r4.y = r4.w * r4.y;
	r7.xyz = r4.yyy * point_lightEv2.xyz;
	r4.xyz = r4.xxx * r7.xyz;
	r4.xyz = r5.zzz * r4.xyz;
	r4.xyz = r3.www * r4.xyz;
	r2.xyz = r4.xyz * r3.zzz + r2.xyz;
	r3.z = abs(specularParam.x);
	r2.xyz = r2.xyz * r3.zzz;
	r4.y = 2;
	r7 = r4.y + -g_specCalc1;
	r6.xyz = r6.xyz * r7.xxx;
	r9.xyz = muzzle_lightpos.xyz + -i.texcoord1.xyz;
	r3.z = dot(r9.xyz, r9.xyz);
	r3.z = 1 / sqrt(r3.z);
	r9.xyz = r3.zzz * r9.xyz;
	r3.z = 1 / r3.z;
	r3.z = -r3.z + muzzle_lightpos.w;
	r3.z = r3.z * muzzle_light.w;
	r4.x = dot(r9.xyz, i.texcoord3.xyz);
	r9.xyz = r4.xxx * muzzle_light.xyz;
	r6.xyz = r9.xyz * r3.zzz + r6.xyz;
	r6.xyz = r8.xyz * r7.yyy + r6.xyz;
	r8.xyz = r3.xxx * light_Color.xyz;
	r3.x = r3.x * 0.5 + 0.5;
	r6.xyz = r8.xyz * r1.xxx + r6.xyz;
	r1.x = -r1.x + 1;
	r4.xz = -r0.yy + r0.xz;
	r3.z = max(abs(r4.x), abs(r4.z));
	r3.z = r3.z + -0.015625;
	r4.x = (-r3.z >= 0) ? 0 : 1;
	r3.z = (r3.z >= 0) ? -0 : -1;
	r3.z = r3.z + r4.x;
	r3.z = (r3.z >= 0) ? -r3.z : -0;
	r0.xz = (r3.zz >= 0) ? r0.yy : r0.xz;
	r0.w = r0.w * prefogcolor_enhance.w;
	o.w = r0.w;
	r8.xyz = r0.xyz * point_lightEv0.xyz;
	r8.xyz = r1.www * r8.xyz;
	r8.xyz = r1.yyy * r8.xyz;
	r7.xyz = r7.zzz * r8.xyz;
	r6.xyz = r0.xyz * r6.xyz + r7.xyz;
	r7.xyz = r0.xyz * point_lightEv1.xyz;
	r7.xyz = r3.yyy * r7.xyz;
	r7.xyz = r2.www * r7.xyz;
	r6.xyz = r7.xyz * r7.www + r6.xyz;
	r7.xyz = r0.xyz * point_lightEv2.xyz;
	r4.xzw = r4.www * r7.xyz;
	r3.yzw = r3.www * r4.xzw;
	r0.w = r4.y + -g_specCalc2.x;
	r3.yzw = r3.yzw * r0.www + r6.xyz;
	r4.xyz = r0.xyz * i.texcoord5.xyz;
	r1.xyw = r1.xxx * r4.xyz;
	r4.xyz = r0.xyz * ambient_rate.xyz;
	r1.xyw = r4.xyz * ambient_rate_rate.xyz + r1.xyw;
	r1.xyw = r3.yzw * r5.www + r1.xyw;
	r4 = tex2D(cubemap_sampler, i.texcoord4);
	r6 = tex2D(cubemap2_sampler, i.texcoord4);
	r7 = lerp(r6, r4, g_CubeBlendParam.x);
	r4 = r7 * ambient_rate_rate.w;
	r4.xyz = r5.yyy * r4.xyz;
	r3 = r3.x * r4;
	r0.w = r3.w * CubeParam.y + CubeParam.x;
	r3.xyz = r0.www * r3.xyz;
	r4.xyz = r0.xyz * r3.xyz;
	r0.xyz = r0.xyz + specularParam.www;
	r5.xyz = r4.xyz * CubeParam.zzz + r1.xyw;
	r4.xyz = r4.xyz * CubeParam.zzz;
	r1.xyw = r1.xyw * -r4.xyz + r5.xyz;
	r0.xyz = r2.xyz * r0.xyz + r1.xyw;
	r0.w = r1.z + -CubeParam.z;
	r0.xyz = r3.xyz * r0.www + r0.xyz;
	r1.xyz = fog.xyz;
	r0.xyz = r0.xyz * prefogcolor_enhance.xyz + -r1.xyz;
	o.xyz = i.texcoord8.www * r0.xyz + fog.xyz;

	return o;
}
