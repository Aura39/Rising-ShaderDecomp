sampler Color_1_sampler : register(s0);
float4 CubeParam : register(c42);
sampler Shadow_Tex_sampler : register(s11);
float4 ambient_rate : register(c40);
float4 ambient_rate_rate : register(c71);
samplerCUBE cubemap2_sampler : register(s9);
samplerCUBE cubemap_sampler : register(s2);
float3 fog : register(c67);
float4 g_All_Offset : register(c76);
float g_CubeBlendParam : register(c175);
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
	r0.y = 1;
	r0.x = r0.y + -spot_param.x;
	r0.x = 1 / r0.x;
	r1.xyz = spot_angle.xyz + -i.texcoord1.xyz;
	r0.z = dot(r1.xyz, r1.xyz);
	r0.z = 1 / sqrt(r0.z);
	r1.xyz = r0.zzz * r1.xyz;
	r0.z = 1 / r0.z;
	r0.w = dot(r1.xyz, lightpos.xyz);
	r0.w = r0.w + -spot_param.x;
	r0.x = r0.x * r0.w;
	r1.x = max(r0.w, 0);
	r0.w = 1 / spot_param.y;
	r0.x = r0.w * r0.x;
	r0.w = frac(-r1.x);
	r0.w = r0.w + r1.x;
	r1.x = dot(lightpos.xyz, i.texcoord3.xyz);
	r0.w = r0.w * r1.x;
	r0.x = r0.x * r0.w;
	r0.w = 1 / spot_angle.w;
	r0.z = r0.w * r0.z;
	r0.z = -r0.z + 1;
	r0.z = r0.z * 10;
	r0.x = r0.z * r0.x;
	r2.x = lerp(r0.x, r1.x, spot_param.z);
	r0.x = (-r2.x >= 0) ? 0 : 1;
	r0.z = r2.x * r0.x;
	r1.xyz = r0.zzz * light_Color.xyz;
	r0.z = dot(-i.texcoord1.xyz, -i.texcoord1.xyz);
	r0.z = 1 / sqrt(r0.z);
	r2.yzw = -i.texcoord1.xyz * r0.zzz + lightpos.xyz;
	r3.xyz = r0.zzz * -i.texcoord1.xyz;
	r4.xyz = normalize(r2.yzw);
	r0.z = dot(r4.xyz, i.texcoord3.xyz);
	r0.x = (-r0.z >= 0) ? 0 : r0.x;
	r1.w = pow(r0.z, specularParam.z);
	r0.x = r0.x * r1.w;
	r0.xzw = r0.xxx * r1.xyz;
	r1.xy = tile.xy * i.texcoord.xy;
	r1 = tex2D(tripleMask_sampler, r1);
	r0.xzw = r0.xzw * r1.zzz;
	r1.x = 1 / i.texcoord7.w;
	r2.yz = r1.xx * i.texcoord7.xy;
	r2.yz = r2.yz * 0.5 + 0.5;
	r2.yz = r2.yz + g_TargetUvParam.xy;
	r4 = tex2D(Shadow_Tex_sampler, r2.yzzw);
	r1.x = r4.z + g_ShadowUse.x;
	r2.yzw = point_lightpos1.xyz + -i.texcoord1.xyz;
	r3.w = dot(r2.yzw, r2.yzw);
	r3.w = 1 / sqrt(r3.w);
	r4.xyz = r2.yzw * r3.www + r3.xyz;
	r2.yzw = r2.yzw * r3.www;
	r3.w = 1 / r3.w;
	r3.w = -r3.w + point_lightpos1.w;
	r3.w = r3.w * point_light1.w;
	r2.y = dot(r2.yzw, i.texcoord3.xyz);
	r5.xyz = normalize(r4.xyz);
	r2.z = dot(r5.xyz, i.texcoord3.xyz);
	r2.w = (-r2.y >= 0) ? 0 : 1;
	r4.x = (-r2.z >= 0) ? 0 : r2.w;
	r4.y = pow(r2.z, specularParam.z);
	r2.z = r4.y * r4.x;
	r2.w = r2.y * r2.w;
	r4.xyz = r2.yyy * point_light1.xyz;
	r4.xyz = r3.www * r4.xyz;
	r5.xyz = r2.www * point_light1.xyz;
	r2.yzw = r2.zzz * r5.xyz;
	r2.yzw = r1.zzz * r2.yzw;
	r2.yzw = r3.www * r2.yzw;
	r5 = g_specCalc1;
	r2.yzw = r2.yzw * r5.xxx;
	r0.xzw = r0.xzw * r1.xxx + r2.yzw;
	r2.yzw = point_lightpos2.xyz + -i.texcoord1.xyz;
	r3.w = dot(r2.yzw, r2.yzw);
	r3.w = 1 / sqrt(r3.w);
	r6.xyz = r2.yzw * r3.www + r3.xyz;
	r2.yzw = r2.yzw * r3.www;
	r3.w = 1 / r3.w;
	r3.w = -r3.w + point_lightpos2.w;
	r3.w = r3.w * point_light2.w;
	r2.y = dot(r2.yzw, i.texcoord3.xyz);
	r7.xyz = normalize(r6.xyz);
	r2.z = dot(r7.xyz, i.texcoord3.xyz);
	r2.w = (-r2.y >= 0) ? 0 : 1;
	r4.w = (-r2.z >= 0) ? 0 : r2.w;
	r5.x = pow(r2.z, specularParam.z);
	r2.z = r4.w * r5.x;
	r2.w = r2.y * r2.w;
	r6.xyz = r2.yyy * point_light2.xyz;
	r6.xyz = r3.www * r6.xyz;
	r7.xyz = r2.www * point_light2.xyz;
	r2.yzw = r2.zzz * r7.xyz;
	r2.yzw = r1.zzz * r2.yzw;
	r2.yzw = r3.www * r2.yzw;
	r0.xzw = r2.yzw * r5.yyy + r0.xzw;
	r2.yzw = point_lightposEv0.xyz + -i.texcoord1.xyz;
	r3.w = dot(r2.yzw, r2.yzw);
	r3.w = 1 / sqrt(r3.w);
	r7.xyz = r2.yzw * r3.www + r3.xyz;
	r2.yzw = r2.yzw * r3.www;
	r3.w = 1 / r3.w;
	r3.w = -r3.w + point_lightposEv0.w;
	r3.w = r3.w * point_lightEv0.w;
	r2.y = dot(r2.yzw, i.texcoord3.xyz);
	r8.xyz = normalize(r7.xyz);
	r2.z = dot(r8.xyz, i.texcoord3.xyz);
	r2.w = (-r2.y >= 0) ? 0 : 1;
	r4.w = (-r2.z >= 0) ? 0 : r2.w;
	r5.x = pow(r2.z, specularParam.z);
	r2.z = r4.w * r5.x;
	r2.w = r2.y * r2.w;
	r7.xyz = r2.www * point_lightEv0.xyz;
	r7.xyz = r2.zzz * r7.xyz;
	r7.xyz = r1.zzz * r7.xyz;
	r7.xyz = r3.www * r7.xyz;
	r0.xzw = r7.xyz * r5.zzz + r0.xzw;
	r5.xyz = point_lightposEv1.xyz + -i.texcoord1.xyz;
	r2.z = dot(r5.xyz, r5.xyz);
	r2.z = 1 / sqrt(r2.z);
	r7.xyz = r5.xyz * r2.zzz + r3.xyz;
	r5.xyz = r2.zzz * r5.xyz;
	r2.z = 1 / r2.z;
	r2.z = -r2.z + point_lightposEv1.w;
	r2.z = r2.z * point_lightEv1.w;
	r2.w = dot(r5.xyz, i.texcoord3.xyz);
	r5.xyz = normalize(r7.xyz);
	r4.w = dot(r5.xyz, i.texcoord3.xyz);
	r5.x = (-r2.w >= 0) ? 0 : 1;
	r5.y = (-r4.w >= 0) ? 0 : r5.x;
	r5.z = pow(r4.w, specularParam.z);
	r4.w = r5.z * r5.y;
	r5.x = r2.w * r5.x;
	r5.xyz = r5.xxx * point_lightEv1.xyz;
	r5.xyz = r4.www * r5.xyz;
	r5.xyz = r1.zzz * r5.xyz;
	r5.xyz = r2.zzz * r5.xyz;
	r0.xzw = r5.xyz * r5.www + r0.xzw;
	r4.w = g_specCalc2.x;
	r5.xyz = point_lightposEv2.xyz + -i.texcoord1.xyz;
	r5.w = dot(r5.xyz, r5.xyz);
	r5.w = 1 / sqrt(r5.w);
	r3.xyz = r5.xyz * r5.www + r3.xyz;
	r5.xyz = r5.www * r5.xyz;
	r5.w = 1 / r5.w;
	r5.w = -r5.w + point_lightposEv2.w;
	r5.w = r5.w * point_lightEv2.w;
	r5.x = dot(r5.xyz, i.texcoord3.xyz);
	r7.xyz = normalize(r3.xyz);
	r3.x = dot(r7.xyz, i.texcoord3.xyz);
	r3.y = (-r5.x >= 0) ? 0 : 1;
	r3.z = (-r3.x >= 0) ? 0 : r3.y;
	r5.y = pow(r3.x, specularParam.z);
	r3.x = r3.z * r5.y;
	r3.y = r5.x * r3.y;
	r7.xyz = r3.yyy * point_lightEv2.xyz;
	r3.xyz = r3.xxx * r7.xyz;
	r3.xyz = r1.zzz * r3.xyz;
	r3.xyz = r5.www * r3.xyz;
	r0.xzw = r3.xyz * r4.www + r0.xzw;
	r1.z = abs(specularParam.x);
	r0.xzw = r0.xzw * r1.zzz;
	r7 = g_specCalc1;
	r7 = -r7 + 2;
	r3.xyz = r4.xyz * r7.xxx;
	r4.xyz = muzzle_lightpos.xyz + -i.texcoord1.xyz;
	r1.z = dot(r4.xyz, r4.xyz);
	r1.z = 1 / sqrt(r1.z);
	r4.xyz = r1.zzz * r4.xyz;
	r1.z = 1 / r1.z;
	r1.z = -r1.z + muzzle_lightpos.w;
	r1.z = r1.z * muzzle_light.w;
	r4.x = dot(r4.xyz, i.texcoord3.xyz);
	r4.xyz = r4.xxx * muzzle_light.xyz;
	r3.xyz = r4.xyz * r1.zzz + r3.xyz;
	r3.xyz = r6.xyz * r7.yyy + r3.xyz;
	r4.xyz = r2.xxx * light_Color.xyz;
	r1.z = r2.x * 0.5 + 0.5;
	r3.xyz = r4.xyz * r1.xxx + r3.xyz;
	r1.x = -r1.x + 1;
	r4.xy = g_All_Offset.xy + i.texcoord.xy;
	r4 = tex2D(Color_1_sampler, r4);
	r5.yz = -r4.yy + r4.xz;
	r2.x = max(abs(r5.y), abs(r5.z));
	r2.x = r2.x + -0.015625;
	r4.w = (-r2.x >= 0) ? 0 : 1;
	r2.x = (r2.x >= 0) ? -0 : -1;
	r2.x = r2.x + r4.w;
	r2.x = (r2.x >= 0) ? -r2.x : -0;
	r4.xz = (r2.xx >= 0) ? r4.yy : r4.xz;
	r6.xyz = r4.xyz * point_lightEv0.xyz;
	r6.xyz = r2.yyy * r6.xyz;
	r6.xyz = r3.www * r6.xyz;
	r6.xyz = r7.zzz * r6.xyz;
	r3.xyz = r4.xyz * r3.xyz + r6.xyz;
	r6.xyz = r4.xyz * point_lightEv1.xyz;
	r2.xyw = r2.www * r6.xyz;
	r2.xyz = r2.zzz * r2.xyw;
	r2.xyz = r2.xyz * r7.www + r3.xyz;
	r3.x = 2;
	r2.w = r3.x + -g_specCalc2.x;
	r3.xyz = r4.xyz * point_lightEv2.xyz;
	r3.xyz = r5.xxx * r3.xyz;
	r3.xyz = r5.www * r3.xyz;
	r2.xyz = r3.xyz * r2.www + r2.xyz;
	r3.xyz = r4.xyz * i.texcoord5.xyz;
	r3.xyz = r1.xxx * r3.xyz;
	r5.xyz = r4.xyz * ambient_rate.xyz;
	r3.xyz = r5.xyz * ambient_rate_rate.xyz + r3.xyz;
	r2.xyz = r2.xyz * r1.www + r3.xyz;
	r3 = tex2D(cubemap_sampler, i.texcoord4);
	r5 = tex2D(cubemap2_sampler, i.texcoord4);
	r6 = lerp(r5, r3, g_CubeBlendParam.x);
	r3 = r6 * ambient_rate_rate.w;
	r3.xyz = r1.yyy * r3.xyz;
	r1 = r1.z * r3;
	r1.w = r1.w * CubeParam.y + CubeParam.x;
	r1.xyz = r1.www * r1.xyz;
	r3.xyz = r4.xyz * r1.xyz;
	r4.xyz = r4.xyz + specularParam.www;
	r5.xyz = r3.xyz * CubeParam.zzz + r2.xyz;
	r3.xyz = r3.xyz * CubeParam.zzz;
	r2.xyz = r2.xyz * -r3.xyz + r5.xyz;
	r0.xzw = r0.xzw * r4.xyz + r2.xyz;
	r0.y = r0.y + -CubeParam.z;
	r0.xyz = r1.xyz * r0.yyy + r0.xzw;
	r1.xyz = fog.xyz;
	r0.xyz = r0.xyz * prefogcolor_enhance.xyz + -r1.xyz;
	o.xyz = i.texcoord8.www * r0.xyz + fog.xyz;
	o.w = prefogcolor_enhance.w;

	return o;
}
