sampler Color_1_sampler : register(s0);
float4 CubeParam : register(c42);
sampler ShadowCast_Tex_sampler : register(s10);
float4 ambient_rate : register(c40);
float4 ambient_rate_rate : register(c71);
samplerCUBE cubemap2_sampler : register(s9);
samplerCUBE cubemap_sampler : register(s1);
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
sampler specularmap_sampler : register(s3);
float4 spot_angle : register(c72);
float4 spot_param : register(c73);

struct PS_IN
{
	float2 texcoord : TEXCOORD;
	float4 texcoord1 : TEXCOORD1;
	float3 texcoord3 : TEXCOORD3;
	float3 texcoord4 : TEXCOORD4;
	float4 texcoord7 : TEXCOORD7;
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
	float3 r9;
	float3 r10;
	r0.x = 1 / i.texcoord7.w;
	r0.xy = r0.xx * i.texcoord7.xy;
	r0.xy = r0.xy * float2(0.5, -0.5) + 0.5;
	r0.xy = r0.xy + g_TargetUvParam.xy;
	r0 = tex2D(ShadowCast_Tex_sampler, r0);
	r0.y = i.texcoord7.z * g_ShadowFarInvPs.y + -g_ShadowFarInvPs.x;
	r0.y = -r0.y + 1;
	r0.x = -r0.x + r0.y;
	r0.x = r0.x + g_ShadowUse.x;
	r0.y = frac(-r0.x);
	r0.x = r0.y + r0.x;
	r0.z = 1;
	r0.y = r0.z + -spot_param.x;
	r0.y = 1 / r0.y;
	r1.xyz = spot_angle.xyz + -i.texcoord1.xyz;
	r0.w = dot(r1.xyz, r1.xyz);
	r0.w = 1 / sqrt(r0.w);
	r1.xyz = r0.www * r1.xyz;
	r0.w = 1 / r0.w;
	r1.x = dot(r1.xyz, lightpos.xyz);
	r1.x = r1.x + -spot_param.x;
	r0.y = r0.y * r1.x;
	r2.x = max(r1.x, 0);
	r1.x = 1 / spot_param.y;
	r0.y = r0.y * r1.x;
	r1.x = frac(-r2.x);
	r1.x = r1.x + r2.x;
	r1.y = dot(lightpos.xyz, i.texcoord3.xyz);
	r1.x = r1.x * abs(r1.y);
	r0.y = r0.y * r1.x;
	r1.x = 1 / spot_angle.w;
	r0.w = r0.w * r1.x;
	r0.w = -r0.w + 1;
	r0.w = r0.w * 10;
	r0.y = r0.w * r0.y;
	r2.x = lerp(r0.y, abs(r1.y), spot_param.z);
	r0.y = (-r2.x >= 0) ? 0 : 1;
	r0.w = r2.x * r0.y;
	r1.xyz = r2.xxx * light_Color.xyz;
	r2.xyz = r0.www * light_Color.xyz;
	r0.w = dot(-i.texcoord1.xyz, -i.texcoord1.xyz);
	r0.w = 1 / sqrt(r0.w);
	r3.xyz = -i.texcoord1.xyz * r0.www + lightpos.xyz;
	r4.xyz = r0.www * -i.texcoord1.xyz;
	r5.xyz = normalize(r3.xyz);
	r0.w = dot(r5.xyz, i.texcoord3.xyz);
	r0.y = (-r0.w >= 0) ? 0 : r0.y;
	r1.w = pow(r0.w, specularParam.z);
	r0.y = r0.y * r1.w;
	r2.xyz = r0.yyy * r2.xyz;
	r0.yw = g_All_Offset.xy + i.texcoord.xy;
	r3 = tex2D(specularmap_sampler, r0.ywzw);
	r5 = tex2D(Color_1_sampler, r0.ywzw);
	r2.xyz = r2.xyz * r3.xyz;
	r6.xyz = point_lightpos1.xyz + -i.texcoord1.xyz;
	r0.y = dot(r6.xyz, r6.xyz);
	r0.y = 1 / sqrt(r0.y);
	r7.xyz = r6.xyz * r0.yyy + r4.xyz;
	r6.xyz = r0.yyy * r6.xyz;
	r0.y = 1 / r0.y;
	r0.y = -r0.y + point_lightpos1.w;
	r0.y = r0.y * point_light1.w;
	r0.w = dot(r6.xyz, i.texcoord3.xyz);
	r6.xyz = normalize(r7.xyz);
	r1.w = dot(r6.xyz, i.texcoord3.xyz);
	r2.w = (-abs(r0.w) >= 0) ? 0 : 1;
	r3.w = (-r1.w >= 0) ? 0 : r2.w;
	r4.w = pow(r1.w, specularParam.z);
	r1.w = r3.w * r4.w;
	r2.w = abs(r0.w) * r2.w;
	r6.xyz = abs(r0.www) * point_light1.xyz;
	r6.xyz = r0.yyy * r6.xyz;
	r7.xyz = r2.www * point_light1.xyz;
	r7.xyz = r1.www * r7.xyz;
	r7.xyz = r3.xyz * r7.xyz;
	r7.xyz = r0.yyy * r7.xyz;
	r8 = g_specCalc1;
	r7.xyz = r7.xyz * r8.xxx;
	r2.xyz = r2.xyz * r0.xxx + r7.xyz;
	r7.xyz = point_lightpos2.xyz + -i.texcoord1.xyz;
	r0.y = dot(r7.xyz, r7.xyz);
	r0.y = 1 / sqrt(r0.y);
	r9.xyz = r7.xyz * r0.yyy + r4.xyz;
	r7.xyz = r0.yyy * r7.xyz;
	r0.y = 1 / r0.y;
	r0.y = -r0.y + point_lightpos2.w;
	r0.y = r0.y * point_light2.w;
	r0.w = dot(r7.xyz, i.texcoord3.xyz);
	r7.xyz = normalize(r9.xyz);
	r1.w = dot(r7.xyz, i.texcoord3.xyz);
	r2.w = (-abs(r0.w) >= 0) ? 0 : 1;
	r3.w = (-r1.w >= 0) ? 0 : r2.w;
	r4.w = pow(r1.w, specularParam.z);
	r1.w = r3.w * r4.w;
	r2.w = abs(r0.w) * r2.w;
	r7.xyz = abs(r0.www) * point_light2.xyz;
	r7.xyz = r0.yyy * r7.xyz;
	r9.xyz = r2.www * point_light2.xyz;
	r9.xyz = r1.www * r9.xyz;
	r9.xyz = r3.xyz * r9.xyz;
	r9.xyz = r0.yyy * r9.xyz;
	r2.xyz = r9.xyz * r8.yyy + r2.xyz;
	r9.xyz = point_lightposEv0.xyz + -i.texcoord1.xyz;
	r0.y = dot(r9.xyz, r9.xyz);
	r0.y = 1 / sqrt(r0.y);
	r10.xyz = r9.xyz * r0.yyy + r4.xyz;
	r9.xyz = r0.yyy * r9.xyz;
	r0.y = 1 / r0.y;
	r0.y = -r0.y + point_lightposEv0.w;
	r0.y = r0.y * point_lightEv0.w;
	r0.w = dot(r9.xyz, i.texcoord3.xyz);
	r9.xyz = normalize(r10.xyz);
	r1.w = dot(r9.xyz, i.texcoord3.xyz);
	r2.w = (-abs(r0.w) >= 0) ? 0 : 1;
	r3.w = (-r1.w >= 0) ? 0 : r2.w;
	r4.w = pow(r1.w, specularParam.z);
	r1.w = r3.w * r4.w;
	r2.w = abs(r0.w) * r2.w;
	r9.xyz = r2.www * point_lightEv0.xyz;
	r9.xyz = r1.www * r9.xyz;
	r9.xyz = r3.xyz * r9.xyz;
	r9.xyz = r0.yyy * r9.xyz;
	r2.xyz = r9.xyz * r8.zzz + r2.xyz;
	r8.xyz = point_lightposEv1.xyz + -i.texcoord1.xyz;
	r1.w = dot(r8.xyz, r8.xyz);
	r1.w = 1 / sqrt(r1.w);
	r9.xyz = r8.xyz * r1.www + r4.xyz;
	r8.xyz = r1.www * r8.xyz;
	r1.w = 1 / r1.w;
	r1.w = -r1.w + point_lightposEv1.w;
	r1.w = r1.w * point_lightEv1.w;
	r2.w = dot(r8.xyz, i.texcoord3.xyz);
	r8.xyz = normalize(r9.xyz);
	r3.w = dot(r8.xyz, i.texcoord3.xyz);
	r4.w = (-abs(r2.w) >= 0) ? 0 : 1;
	r6.w = (-r3.w >= 0) ? 0 : r4.w;
	r7.w = pow(r3.w, specularParam.z);
	r3.w = r6.w * r7.w;
	r4.w = abs(r2.w) * r4.w;
	r8.xyz = r4.www * point_lightEv1.xyz;
	r8.xyz = r3.www * r8.xyz;
	r8.xyz = r3.xyz * r8.xyz;
	r8.xyz = r1.www * r8.xyz;
	r2.xyz = r8.xyz * r8.www + r2.xyz;
	r3.w = g_specCalc2.x;
	r8.xyz = point_lightposEv2.xyz + -i.texcoord1.xyz;
	r4.w = dot(r8.xyz, r8.xyz);
	r4.w = 1 / sqrt(r4.w);
	r4.xyz = r8.xyz * r4.www + r4.xyz;
	r8.xyz = r4.www * r8.xyz;
	r4.w = 1 / r4.w;
	r4.w = -r4.w + point_lightposEv2.w;
	r4.w = r4.w * point_lightEv2.w;
	r6.w = dot(r8.xyz, i.texcoord3.xyz);
	r8.xyz = normalize(r4.xyz);
	r4.x = dot(r8.xyz, i.texcoord3.xyz);
	r4.y = (-abs(r6.w) >= 0) ? 0 : 1;
	r4.z = (-r4.x >= 0) ? 0 : r4.y;
	r7.w = pow(r4.x, specularParam.z);
	r4.x = r4.z * r7.w;
	r4.y = abs(r6.w) * r4.y;
	r8.xyz = r4.yyy * point_lightEv2.xyz;
	r4.xyz = r4.xxx * r8.xyz;
	r3.xyz = r3.xyz * r4.xyz;
	r3.xyz = r4.www * r3.xyz;
	r2.xyz = r3.xyz * r3.www + r2.xyz;
	r3.x = abs(specularParam.x);
	r2.xyz = r2.xyz * r3.xxx;
	r3 = g_specCalc1;
	r3 = -r3 + 2;
	r4.xyz = r3.xxx * r6.xyz;
	r6.xyz = muzzle_lightpos.xyz + -i.texcoord1.xyz;
	r3.x = dot(r6.xyz, r6.xyz);
	r3.x = 1 / sqrt(r3.x);
	r6.xyz = r3.xxx * r6.xyz;
	r3.x = 1 / r3.x;
	r3.x = -r3.x + muzzle_lightpos.w;
	r3.x = r3.x * muzzle_light.w;
	r6.x = dot(r6.xyz, i.texcoord3.xyz);
	r6.xyz = abs(r6.xxx) * muzzle_light.xyz;
	r4.xyz = r6.xyz * r3.xxx + r4.xyz;
	r4.xyz = r7.xyz * r3.yyy + r4.xyz;
	r1.xyz = r1.xyz * r0.xxx + r4.xyz;
	r3.xy = -r5.yy + r5.xz;
	r0.x = max(abs(r3.x), abs(r3.y));
	r0.x = r0.x + -0.015625;
	r3.x = (-r0.x >= 0) ? 0 : 1;
	r0.x = (r0.x >= 0) ? -0 : -1;
	r0.x = r0.x + r3.x;
	r0.x = (r0.x >= 0) ? -r0.x : -0;
	r5.xz = (r0.xx >= 0) ? r5.yy : r5.xz;
	r0.x = r5.w * ambient_rate.w;
	r4.xyz = r5.xyz * point_lightEv0.xyz;
	r4.xyz = abs(r0.www) * r4.xyz;
	r4.xyz = r0.yyy * r4.xyz;
	r3.xyz = r3.zzz * r4.xyz;
	r1.xyz = r5.xyz * r1.xyz + r3.xyz;
	r3.xyz = r5.xyz * point_lightEv1.xyz;
	r3.xyz = abs(r2.www) * r3.xyz;
	r3.xyz = r1.www * r3.xyz;
	r1.xyz = r3.xyz * r3.www + r1.xyz;
	r3.xyz = r5.xyz * point_lightEv2.xyz;
	r3.xyz = abs(r6.www) * r3.xyz;
	r3.xyz = r4.www * r3.xyz;
	r4.x = 2;
	r0.y = r4.x + -g_specCalc2.x;
	r1.xyz = r3.xyz * r0.yyy + r1.xyz;
	r3.xyz = r5.xyz * ambient_rate.xyz;
	r1.xyz = r3.xyz * ambient_rate_rate.xyz + r1.xyz;
	r3 = tex2D(cubemap_sampler, i.texcoord4);
	r4 = tex2D(cubemap2_sampler, i.texcoord4);
	r6 = lerp(r4, r3, g_CubeBlendParam.x);
	r3 = r6 * ambient_rate_rate.w;
	r0.y = r3.w * CubeParam.y + CubeParam.x;
	r3.xyz = r0.yyy * r3.xyz;
	r4.xyz = r5.xyz * r3.xyz;
	r5.xyz = r5.xyz + specularParam.www;
	r6.xyz = r4.xyz * CubeParam.zzz + r1.xyz;
	r4.xyz = r4.xyz * CubeParam.zzz;
	r1.xyz = r1.xyz * -r4.xyz + r6.xyz;
	r1.xyz = r2.xyz * r5.xyz + r1.xyz;
	r2.xyz = r2.xyz * r5.xyz;
	r0.y = r0.z + -CubeParam.z;
	r0.yzw = r3.xyz * r0.yyy + r1.xyz;
	r1.xyz = fog.xyz;
	r0.yzw = r0.yzw * prefogcolor_enhance.xyz + -r1.xyz;
	o.xyz = i.texcoord1.www * r0.yzw + fog.xyz;
	r0.y = max(r2.x, r2.y);
	r1.x = max(r0.y, r2.z);
	r0.y = r1.x * specularParam.x;
	r0.z = max(CubeParam.x, CubeParam.y);
	r0.y = r3.w * r0.z + r0.y;
	r1.x = max(r0.y, r0.x);
	r0.x = r1.x * prefogcolor_enhance.w;
	o.w = r0.x;

	return o;
}
