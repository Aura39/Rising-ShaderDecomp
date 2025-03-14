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
float4 tile : register(c45);
sampler tripleMask_sampler : register(s1);
float4x4 viewInverseMatrix : register(c12);

struct PS_IN
{
	float2 texcoord : TEXCOORD;
	float4 texcoord1 : TEXCOORD1;
	float4 texcoord2 : TEXCOORD2;
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
	float3 r8;
	float4 r9;
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
	r0.y = 1 / spot_angle.w;
	r1.xyz = spot_angle.xyz + -i.texcoord1.xyz;
	r0.z = dot(r1.xyz, r1.xyz);
	r0.z = 1 / sqrt(r0.z);
	r0.w = 1 / r0.z;
	r1.xyz = r0.zzz * r1.xyz;
	r0.z = dot(r1.xyz, lightpos.xyz);
	r0.z = r0.z + -spot_param.x;
	r0.y = r0.y * r0.w;
	r0.y = -r0.y + 1;
	r0.y = r0.y * 10;
	r1.z = 1;
	r0.w = r1.z + -spot_param.x;
	r0.w = 1 / r0.w;
	r0.w = r0.w * r0.z;
	r1.x = max(r0.z, 0);
	r0.z = 1 / spot_param.y;
	r0.z = r0.z * r0.w;
	r0.w = frac(-r1.x);
	r0.w = r0.w + r1.x;
	r2.xyz = i.texcoord3.xyz;
	r1.xyw = r2.yzx * i.texcoord2.zxy;
	r1.xyw = i.texcoord2.yzx * r2.zxy + -r1.xyw;
	r2.xy = tile.xy;
	r2.xy = i.texcoord.xy * r2.xy + g_All_Offset.xy;
	r2 = tex2D(normalmap_sampler, r2);
	r2.xyz = r2.xyz + -0.5;
	r1.xyw = r1.xyw * -r2.yyy;
	r2.x = r2.x * i.texcoord2.w;
	r1.xyw = r2.xxx * i.texcoord2.xyz + r1.xyw;
	r1.xyw = r2.zzz * i.texcoord3.xyz + r1.xyw;
	r2.xyz = normalize(r1.xyw);
	r1.x = dot(lightpos.xyz, r2.xyz);
	r0.w = r0.w * abs(r1.x);
	r0.z = r0.z * r0.w;
	r0.y = r0.y * r0.z;
	r2.w = lerp(r0.y, abs(r1.x), spot_param.z);
	r0.y = (-r2.w >= 0) ? 0 : 1;
	r0.z = dot(-i.texcoord1.xyz, -i.texcoord1.xyz);
	r0.z = 1 / sqrt(r0.z);
	r3.xyz = -i.texcoord1.xyz * r0.zzz + lightpos.xyz;
	r4.xyz = r0.zzz * -i.texcoord1.xyz;
	r5.xyz = normalize(r3.xyz);
	r0.z = dot(r5.xyz, r2.xyz);
	r0.w = (-r0.z >= 0) ? 0 : r0.y;
	r0.y = r2.w * r0.y;
	r3.xyz = r0.yyy * light_Color.xyz;
	r1.y = pow(r0.z, specularParam.z);
	r0.y = r0.w * r1.y;
	r0.yzw = r0.yyy * r3.xyz;
	r1.yw = tile.xy * i.texcoord.xy;
	r3 = tex2D(tripleMask_sampler, r1.ywzw);
	r0.yzw = r0.yzw * r3.zzz;
	r5.xyz = point_lightpos1.xyz + -i.texcoord1.xyz;
	r1.y = dot(r5.xyz, r5.xyz);
	r1.y = 1 / sqrt(r1.y);
	r6.xyz = r5.xyz * r1.yyy + r4.xyz;
	r5.xyz = r1.yyy * r5.xyz;
	r1.y = 1 / r1.y;
	r1.y = -r1.y + point_lightpos1.w;
	r1.y = r1.y * point_light1.w;
	r1.w = dot(r5.xyz, r2.xyz);
	r5.xyz = normalize(r6.xyz);
	r4.w = dot(r5.xyz, r2.xyz);
	r5.x = (-abs(r1.w) >= 0) ? 0 : 1;
	r5.y = (-r4.w >= 0) ? 0 : r5.x;
	r5.z = pow(r4.w, specularParam.z);
	r4.w = r5.z * r5.y;
	r5.x = abs(r1.w) * r5.x;
	r5.yzw = abs(r1.www) * point_light1.xyz;
	r5.yzw = r1.yyy * r5.yzw;
	r6.xyz = r5.xxx * point_light1.xyz;
	r6.xyz = r4.www * r6.xyz;
	r6.xyz = r3.zzz * r6.xyz;
	r6.xyz = r1.yyy * r6.xyz;
	r7 = g_specCalc1;
	r6.xyz = r6.xyz * r7.xxx;
	r0.yzw = r0.yzw * r0.xxx + r6.xyz;
	r6.xyz = point_lightpos2.xyz + -i.texcoord1.xyz;
	r1.y = dot(r6.xyz, r6.xyz);
	r1.y = 1 / sqrt(r1.y);
	r8.xyz = r6.xyz * r1.yyy + r4.xyz;
	r6.xyz = r1.yyy * r6.xyz;
	r1.y = 1 / r1.y;
	r1.y = -r1.y + point_lightpos2.w;
	r1.y = r1.y * point_light2.w;
	r1.w = dot(r6.xyz, r2.xyz);
	r6.xyz = normalize(r8.xyz);
	r4.w = dot(r6.xyz, r2.xyz);
	r5.x = (-abs(r1.w) >= 0) ? 0 : 1;
	r6.x = (-r4.w >= 0) ? 0 : r5.x;
	r6.y = pow(r4.w, specularParam.z);
	r4.w = r6.y * r6.x;
	r5.x = abs(r1.w) * r5.x;
	r6.xyz = abs(r1.www) * point_light2.xyz;
	r6.xyz = r1.yyy * r6.xyz;
	r8.xyz = r5.xxx * point_light2.xyz;
	r8.xyz = r4.www * r8.xyz;
	r8.xyz = r3.zzz * r8.xyz;
	r8.xyz = r1.yyy * r8.xyz;
	r0.yzw = r8.xyz * r7.yyy + r0.yzw;
	r8.xyz = point_lightposEv0.xyz + -i.texcoord1.xyz;
	r1.y = dot(r8.xyz, r8.xyz);
	r1.y = 1 / sqrt(r1.y);
	r9.xyz = r8.xyz * r1.yyy + r4.xyz;
	r8.xyz = r1.yyy * r8.xyz;
	r1.y = 1 / r1.y;
	r1.y = -r1.y + point_lightposEv0.w;
	r1.y = r1.y * point_lightEv0.w;
	r1.w = dot(r8.xyz, r2.xyz);
	r8.xyz = normalize(r9.xyz);
	r4.w = dot(r8.xyz, r2.xyz);
	r5.x = (-abs(r1.w) >= 0) ? 0 : 1;
	r6.w = (-r4.w >= 0) ? 0 : r5.x;
	r7.x = pow(r4.w, specularParam.z);
	r4.w = r6.w * r7.x;
	r5.x = abs(r1.w) * r5.x;
	r8.xyz = r5.xxx * point_lightEv0.xyz;
	r8.xyz = r4.www * r8.xyz;
	r8.xyz = r3.zzz * r8.xyz;
	r8.xyz = r1.yyy * r8.xyz;
	r0.yzw = r8.xyz * r7.zzz + r0.yzw;
	r7.xyz = point_lightposEv1.xyz + -i.texcoord1.xyz;
	r4.w = dot(r7.xyz, r7.xyz);
	r4.w = 1 / sqrt(r4.w);
	r8.xyz = r7.xyz * r4.www + r4.xyz;
	r7.xyz = r4.www * r7.xyz;
	r4.w = 1 / r4.w;
	r4.w = -r4.w + point_lightposEv1.w;
	r4.w = r4.w * point_lightEv1.w;
	r5.x = dot(r7.xyz, r2.xyz);
	r7.xyz = normalize(r8.xyz);
	r6.w = dot(r7.xyz, r2.xyz);
	r7.x = (-abs(r5.x) >= 0) ? 0 : 1;
	r7.y = (-r6.w >= 0) ? 0 : r7.x;
	r7.z = pow(r6.w, specularParam.z);
	r6.w = r7.z * r7.y;
	r7.x = abs(r5.x) * r7.x;
	r7.xyz = r7.xxx * point_lightEv1.xyz;
	r7.xyz = r6.www * r7.xyz;
	r7.xyz = r3.zzz * r7.xyz;
	r7.xyz = r4.www * r7.xyz;
	r0.yzw = r7.xyz * r7.www + r0.yzw;
	r6.w = g_specCalc2.x;
	r7.xyz = point_lightposEv2.xyz + -i.texcoord1.xyz;
	r7.w = dot(r7.xyz, r7.xyz);
	r7.w = 1 / sqrt(r7.w);
	r4.xyz = r7.xyz * r7.www + r4.xyz;
	r7.xyz = r7.www * r7.xyz;
	r7.w = 1 / r7.w;
	r7.w = -r7.w + point_lightposEv2.w;
	r7.w = r7.w * point_lightEv2.w;
	r7.x = dot(r7.xyz, r2.xyz);
	r8.xyz = normalize(r4.xyz);
	r4.x = dot(r8.xyz, r2.xyz);
	r4.y = (-abs(r7.x) >= 0) ? 0 : 1;
	r4.z = (-r4.x >= 0) ? 0 : r4.y;
	r7.y = pow(r4.x, specularParam.z);
	r4.x = r4.z * r7.y;
	r4.y = abs(r7.x) * r4.y;
	r8.xyz = r4.yyy * point_lightEv2.xyz;
	r4.xyz = r4.xxx * r8.xyz;
	r4.xyz = r3.zzz * r4.xyz;
	r4.xyz = r7.www * r4.xyz;
	r0.yzw = r4.xyz * r6.www + r0.yzw;
	r3.z = r2.w + -0.5;
	r4.xyz = r2.www * light_Color.xyz;
	r2.w = r3.z + r3.x;
	r0.yzw = r0.yzw * r2.www;
	r3.z = abs(specularParam.x);
	r0.yzw = r0.yzw * r3.zzz;
	r8.xyz = muzzle_lightpos.xyz + -i.texcoord1.xyz;
	r3.z = dot(r8.xyz, r8.xyz);
	r3.z = 1 / sqrt(r3.z);
	r8.xyz = r3.zzz * r8.xyz;
	r3.z = 1 / r3.z;
	r3.z = -r3.z + muzzle_lightpos.w;
	r3.z = r3.z * muzzle_light.w;
	r6.w = dot(r8.xyz, r2.xyz);
	r8.xyz = abs(r6.www) * muzzle_light.xyz;
	r9 = g_specCalc1;
	r9 = -r9 + 2;
	r5.yzw = r5.yzw * r9.xxx;
	r5.yzw = r8.xyz * r3.zzz + r5.yzw;
	r5.yzw = r6.xyz * r9.yyy + r5.yzw;
	r4.xyz = r4.xyz * r0.xxx + r5.yzw;
	r5.yz = g_All_Offset.xy + i.texcoord.xy;
	r6 = tex2D(Color_1_sampler, r5.yzzw);
	r5.yz = -r6.yy + r6.xz;
	r0.x = max(abs(r5.y), abs(r5.z));
	r0.x = r0.x + -0.015625;
	r3.z = (-r0.x >= 0) ? 0 : 1;
	r0.x = (r0.x >= 0) ? -0 : -1;
	r0.x = r0.x + r3.z;
	r0.x = (r0.x >= 0) ? -r0.x : -0;
	r6.xz = (r0.xx >= 0) ? r6.yy : r6.xz;
	r0.x = r6.w * ambient_rate.w;
	r5.yzw = r2.www * r6.xyz;
	r8.xyz = r5.yzw * point_lightEv0.xyz;
	r8.xyz = abs(r1.www) * r8.xyz;
	r8.xyz = r1.yyy * r8.xyz;
	r8.xyz = r9.zzz * r8.xyz;
	r4.xyz = r5.yzw * r4.xyz + r8.xyz;
	r8.xyz = r5.yzw * point_lightEv1.xyz;
	r5.yzw = r5.yzw * point_lightEv2.xyz;
	r5.yzw = abs(r7.xxx) * r5.yzw;
	r5.yzw = r7.www * r5.yzw;
	r7.xyz = abs(r5.xxx) * r8.xyz;
	r7.xyz = r4.www * r7.xyz;
	r4.xyz = r7.xyz * r9.www + r4.xyz;
	r5.x = 2;
	r1.y = r5.x + -g_specCalc2.x;
	r4.xyz = r5.yzw * r1.yyy + r4.xyz;
	r4.xyz = r3.www * r4.xyz;
	r1.y = dot(lightpos.xyz, i.texcoord3.xyz);
	r1.x = -r1.y + r1.x;
	r1.x = r1.x + 1;
	r3.xzw = r3.xxx * r6.xyz;
	r3.xzw = r3.xzw * ambient_rate.xyz;
	r3.xzw = r3.xzw * ambient_rate_rate.xyz;
	r1.xyw = r3.xzw * r1.xxx + r4.xyz;
	r4.x = dot(r2.xyz, transpose(viewInverseMatrix)[0].xyz);
	r4.y = dot(r2.xyz, transpose(viewInverseMatrix)[1].xyz);
	r4.z = dot(r2.xyz, transpose(viewInverseMatrix)[2].xyz);
	r2.x = dot(i.texcoord4.xyz, r4.xyz);
	r2.x = r2.x + r2.x;
	r4.xyz = r4.xyz * -r2.xxx + i.texcoord4.xyz;
	r4.w = -r4.z;
	r5 = tex2D(cubemap_sampler, r4.xyww);
	r4 = tex2D(cubemap2_sampler, r4.xyww);
	r7 = lerp(r4, r5, g_CubeBlendParam.x);
	r4 = r7 * ambient_rate_rate.w;
	r2.xyz = r3.yyy * r4.xyz;
	r3.x = r4.w * CubeParam.y + CubeParam.x;
	r2.xyz = r2.xyz * r3.xxx;
	r2.xyz = r2.www * r2.xyz;
	r3.xyz = r6.xyz * r2.xyz;
	r4.xyz = r6.xyz + specularParam.www;
	r5.xyz = r3.xyz * CubeParam.zzz + r1.xyw;
	r3.xyz = r3.xyz * CubeParam.zzz;
	r1.xyw = r1.xyw * -r3.xyz + r5.xyz;
	r1.xyw = r0.yzw * r4.xyz + r1.xyw;
	r0.yzw = r0.yzw * r4.xyz;
	r1.z = r1.z + -CubeParam.z;
	r1.xyz = r2.xyz * r1.zzz + r1.xyw;
	r2.xyz = fog.xyz;
	r1.xyz = r1.xyz * prefogcolor_enhance.xyz + -r2.xyz;
	o.xyz = i.texcoord1.www * r1.xyz + fog.xyz;
	r1.x = max(r0.y, r0.z);
	r2.x = max(r1.x, r0.w);
	r0.y = r2.x * specularParam.x;
	r0.z = max(CubeParam.x, CubeParam.y);
	r0.y = r4.w * r0.z + r0.y;
	r1.x = max(r0.y, r0.x);
	r0.x = r1.x * prefogcolor_enhance.w;
	o.w = r0.x;

	return o;
}
