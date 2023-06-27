sampler Color_1_sampler;
sampler Shadow_Tex_sampler;
float4 VelvetParam;
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
sampler normalmap_sampler;
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
float ss_scat_pow;
float ss_scat_rate;
float4 tile;
sampler tripleMask_sampler;

struct PS_IN
{
	float2 texcoord : TEXCOORD;
	float4 texcoord1 : TEXCOORD1;
	float4 texcoord2 : TEXCOORD2;
	float3 texcoord3 : TEXCOORD3;
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
	float4 r9;
	r0.x = 1 / i.texcoord7.w;
	r0.xy = r0.xx * i.texcoord7.xy;
	r0.xy = r0.xy * float2(0.5, -0.5) + 0.5;
	r0.xy = r0.xy + g_TargetUvParam.xy;
	r0 = tex2D(Shadow_Tex_sampler, r0);
	r0.x = r0.z + g_ShadowUse.x;
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
	r1.y = 1;
	r0.w = r1.y + -spot_param.x;
	r0.w = 1 / r0.w;
	r0.w = r0.w * r0.z;
	r1.x = max(r0.z, 0);
	r0.z = 1 / spot_param.y;
	r0.z = r0.z * r0.w;
	r0.w = frac(-r1.x);
	r0.w = r0.w + r1.x;
	r2.xyz = i.texcoord3.xyz;
	r1.xzw = r2.yzx * i.texcoord2.zxy;
	r1.xzw = i.texcoord2.yzx * r2.zxy + -r1.xzw;
	r2.xy = tile.xy;
	r2.xy = i.texcoord.xy * r2.xy + g_All_Offset.xy;
	r2 = tex2D(normalmap_sampler, r2);
	r2.xyz = r2.xyz + -0.5;
	r1.xzw = r1.xzw * -r2.yyy;
	r2.x = r2.x * i.texcoord2.w;
	r1.xzw = r2.xxx * i.texcoord2.xyz + r1.xzw;
	r1.xzw = r2.zzz * i.texcoord3.xyz + r1.xzw;
	r2.x = dot(r1.xzw, r1.xzw);
	r2.x = 1 / sqrt(r2.x);
	r2.yzw = r1.xzw * r2.xxx;
	r1.x = r1.w * -r2.x + 1;
	r1.z = dot(lightpos.xyz, r2.yzw);
	r1.w = r1.z;
	r0.w = r0.w * r1.w;
	r0.z = r0.z * r0.w;
	r0.y = r0.y * r0.z;
	r2.x = lerp(r0.y, r1.w, spot_param.z);
	r0.y = (-r2.x >= 0) ? 0 : 1;
	r0.z = dot(-i.texcoord1.xyz, -i.texcoord1.xyz);
	r0.z = 1 / sqrt(r0.z);
	r3.xyz = -i.texcoord1.xyz * r0.zzz + lightpos.xyz;
	r4.xyz = r0.zzz * -i.texcoord1.xyz;
	r5.xyz = normalize(r3.xyz);
	r0.z = dot(r5.xyz, r2.yzw);
	r0.w = (-r0.z >= 0) ? 0 : r0.y;
	r0.y = r2.x * r0.y;
	r3.xyz = r0.yyy * light_Color.xyz;
	r1.w = pow(r0.z, specularParam.z);
	r0.y = r0.w * r1.w;
	r0.yzw = r0.yyy * r3.xyz;
	r3.xy = tile.xy * i.texcoord.xy;
	r3 = tex2D(tripleMask_sampler, r3);
	r0.yzw = r0.yzw * r3.zzz;
	r5.xyz = point_lightpos1.xyz + -i.texcoord1.xyz;
	r1.w = dot(r5.xyz, r5.xyz);
	r1.w = 1 / sqrt(r1.w);
	r6.xyz = r5.xyz * r1.www + r4.xyz;
	r5.xyz = r1.www * r5.xyz;
	r1.w = 1 / r1.w;
	r1.w = -r1.w + point_lightpos1.w;
	r1.w = r1.w * point_light1.w;
	r3.y = dot(r5.xyz, r2.yzw);
	r5.xyz = normalize(r6.xyz);
	r4.w = dot(r5.xyz, r2.yzw);
	r5.x = (-r3.y >= 0) ? 0 : 1;
	r5.y = (-r4.w >= 0) ? 0 : r5.x;
	r5.z = pow(r4.w, specularParam.z);
	r4.w = r5.z * r5.y;
	r5.x = r3.y * r5.x;
	r5.yzw = r3.yyy * point_light1.xyz;
	r5.yzw = r1.www * r5.yzw;
	r6.xyz = r5.xxx * point_light1.xyz;
	r6.xyz = r4.www * r6.xyz;
	r6.xyz = r3.zzz * r6.xyz;
	r6.xyz = r1.www * r6.xyz;
	r7 = g_specCalc1;
	r6.xyz = r6.xyz * r7.xxx;
	r0.yzw = r0.yzw * r0.xxx + r6.xyz;
	r6.xyz = point_lightpos2.xyz + -i.texcoord1.xyz;
	r1.w = dot(r6.xyz, r6.xyz);
	r1.w = 1 / sqrt(r1.w);
	r8.xyz = r6.xyz * r1.www + r4.xyz;
	r6.xyz = r1.www * r6.xyz;
	r1.w = 1 / r1.w;
	r1.w = -r1.w + point_lightpos2.w;
	r1.w = r1.w * point_light2.w;
	r3.y = dot(r6.xyz, r2.yzw);
	r6.xyz = normalize(r8.xyz);
	r4.w = dot(r6.xyz, r2.yzw);
	r5.x = (-r3.y >= 0) ? 0 : 1;
	r6.x = (-r4.w >= 0) ? 0 : r5.x;
	r6.y = pow(r4.w, specularParam.z);
	r4.w = r6.y * r6.x;
	r5.x = r3.y * r5.x;
	r6.xyz = r3.yyy * point_light2.xyz;
	r6.xyz = r1.www * r6.xyz;
	r8.xyz = r5.xxx * point_light2.xyz;
	r8.xyz = r4.www * r8.xyz;
	r8.xyz = r3.zzz * r8.xyz;
	r8.xyz = r1.www * r8.xyz;
	r0.yzw = r8.xyz * r7.yyy + r0.yzw;
	r8.xyz = point_lightposEv0.xyz + -i.texcoord1.xyz;
	r1.w = dot(r8.xyz, r8.xyz);
	r1.w = 1 / sqrt(r1.w);
	r9.xyz = r8.xyz * r1.www + r4.xyz;
	r8.xyz = r1.www * r8.xyz;
	r1.w = 1 / r1.w;
	r1.w = -r1.w + point_lightposEv0.w;
	r1.w = r1.w * point_lightEv0.w;
	r3.y = dot(r8.xyz, r2.yzw);
	r8.xyz = normalize(r9.xyz);
	r4.w = dot(r8.xyz, r2.yzw);
	r5.x = (-r3.y >= 0) ? 0 : 1;
	r6.w = (-r4.w >= 0) ? 0 : r5.x;
	r7.x = pow(r4.w, specularParam.z);
	r4.w = r6.w * r7.x;
	r5.x = r3.y * r5.x;
	r8.xyz = r5.xxx * point_lightEv0.xyz;
	r8.xyz = r4.www * r8.xyz;
	r8.xyz = r3.zzz * r8.xyz;
	r8.xyz = r1.www * r8.xyz;
	r0.yzw = r8.xyz * r7.zzz + r0.yzw;
	r7.xyz = point_lightposEv1.xyz + -i.texcoord1.xyz;
	r4.w = dot(r7.xyz, r7.xyz);
	r4.w = 1 / sqrt(r4.w);
	r8.xyz = r7.xyz * r4.www + r4.xyz;
	r7.xyz = r4.www * r7.xyz;
	r4.w = 1 / r4.w;
	r4.w = -r4.w + point_lightposEv1.w;
	r4.w = r4.w * point_lightEv1.w;
	r5.x = dot(r7.xyz, r2.yzw);
	r7.xyz = normalize(r8.xyz);
	r6.w = dot(r7.xyz, r2.yzw);
	r7.x = (-r5.x >= 0) ? 0 : 1;
	r7.y = (-r6.w >= 0) ? 0 : r7.x;
	r7.z = pow(r6.w, specularParam.z);
	r6.w = r7.z * r7.y;
	r7.x = r5.x * r7.x;
	r7.xyz = r7.xxx * point_lightEv1.xyz;
	r7.xyz = r6.www * r7.xyz;
	r7.xyz = r3.zzz * r7.xyz;
	r7.xyz = r4.www * r7.xyz;
	r0.yzw = r7.xyz * r7.www + r0.yzw;
	r6.w = g_specCalc2.x;
	r7.xyz = point_lightposEv2.xyz + -i.texcoord1.xyz;
	r7.w = dot(r7.xyz, r7.xyz);
	r7.w = 1 / sqrt(r7.w);
	r8.xyz = r7.xyz * r7.www + r4.xyz;
	r4.x = dot(r4.xyz, r2.yzw);
	r4.x = -r4.x + 1;
	r8.w = pow(r4.x, VelvetParam.y);
	r4.xyz = r7.www * r7.xyz;
	r7.x = 1 / r7.w;
	r7.x = -r7.x + point_lightposEv2.w;
	r7.x = r7.x * point_lightEv2.w;
	r4.x = dot(r4.xyz, r2.yzw);
	r9.xyz = normalize(r8.xyz);
	r4.y = dot(r9.xyz, r2.yzw);
	r4.z = (-r4.x >= 0) ? 0 : 1;
	r7.y = (-r4.y >= 0) ? 0 : r4.z;
	r7.z = pow(r4.y, specularParam.z);
	r4.y = r7.z * r7.y;
	r4.z = r4.x * r4.z;
	r7.yzw = r4.zzz * point_lightEv2.xyz;
	r7.yzw = r4.yyy * r7.yzw;
	r7.yzw = r3.zzz * r7.yzw;
	r7.yzw = r7.xxx * r7.yzw;
	r0.yzw = r7.yzw * r6.www + r0.yzw;
	r3.z = r2.x + -0.5;
	r7.yzw = r2.xxx * light_Color.xyz;
	r2.x = r3.z + r3.x;
	r0.yzw = r0.yzw * r2.xxx;
	r3.z = abs(specularParam.x);
	r0.yzw = r0.yzw * r3.zzz;
	r8.xyz = muzzle_lightpos.xyz + -i.texcoord1.xyz;
	r3.z = dot(r8.xyz, r8.xyz);
	r3.z = 1 / sqrt(r3.z);
	r8.xyz = r3.zzz * r8.xyz;
	r3.z = 1 / r3.z;
	r3.z = -r3.z + muzzle_lightpos.w;
	r3.z = r3.z * muzzle_light.w;
	r2.y = dot(r8.xyz, r2.yzw);
	r2.yzw = r2.yyy * muzzle_light.xyz;
	r9 = g_specCalc1;
	r9 = -r9 + 2;
	r5.yzw = r5.yzw * r9.xxx;
	r2.yzw = r2.yzw * r3.zzz + r5.yzw;
	r2.yzw = r6.xyz * r9.yyy + r2.yzw;
	r2.yzw = r7.yzw * r0.xxx + r2.yzw;
	r4.yz = g_All_Offset.xy + i.texcoord.xy;
	r6 = tex2D(Color_1_sampler, r4.yzzw);
	r4.yz = -r6.yy + r6.xz;
	r0.x = max(abs(r4.y), abs(r4.z));
	r0.x = r0.x + -0.015625;
	r3.z = (-r0.x >= 0) ? 0 : 1;
	r0.x = (r0.x >= 0) ? -0 : -1;
	r0.x = r0.x + r3.z;
	r0.x = (r0.x >= 0) ? -r0.x : -0;
	r6.xz = (r0.xx >= 0) ? r6.yy : r6.xz;
	r5.yzw = r2.xxx * r6.xyz;
	r7.yzw = r5.yzw * point_lightEv0.xyz;
	r7.yzw = r3.yyy * r7.yzw;
	r7.yzw = r1.www * r7.yzw;
	r7.yzw = r9.zzz * r7.yzw;
	r2.xyz = r5.yzw * r2.yzw + r7.yzw;
	r7.yzw = r5.yzw * point_lightEv1.xyz;
	r5.yzw = r5.yzw * point_lightEv2.xyz;
	r4.xyz = r4.xxx * r5.yzw;
	r4.xyz = r7.xxx * r4.xyz;
	r5.xyz = r5.xxx * r7.yzw;
	r5.xyz = r4.www * r5.xyz;
	r2.xyz = r5.xyz * r9.www + r2.xyz;
	r0.x = 2;
	r0.x = r0.x + -g_specCalc2.x;
	r2.xyz = r4.xyz * r0.xxx + r2.xyz;
	r4.xyz = r6.xyz * r8.www;
	r4.xyz = r4.xyz * light_Color.xyz;
	r4.xyz = r4.xyz * VelvetParam.xxx;
	r2.xyz = r2.xyz * r3.www + r4.xyz;
	r3.xyz = r3.xxx * r6.xyz;
	r4.xyz = r6.xyz + specularParam.www;
	r0.x = dot(lightpos.xyz, i.texcoord3.xyz);
	r0.x = -r0.x + r1.z;
	r0.x = r0.x + 1;
	r5.xyz = r3.xyz * ambient_rate.xyz;
	r3.xyz = r1.xxx * r3.xyz;
	r1.x = r1.x + -ss_scat_rate.x;
	r3.xyz = r3.xyz * ss_scat_pow.xxx;
	r5.xyz = r5.xyz * ambient_rate_rate.xyz;
	r2.xyz = r5.xyz * r0.xxx + r2.xyz;
	r0.xyz = r0.yzw * r4.xyz + r2.xyz;
	r0.w = r1.y + -ss_scat_rate.x;
	r0.w = 1 / r0.w;
	r0.w = r0.w * r1.x;
	r1.x = r1.x;
	r1.y = frac(-r1.x);
	r1.x = r1.y + r1.x;
	r0.w = r0.w * r1.x;
	r0.xyz = r3.xyz * r0.www + r0.xyz;
	r1.xyz = fog.xyz;
	r0.xyz = r0.xyz * prefogcolor_enhance.xyz + -r1.xyz;
	o.xyz = i.texcoord1.www * r0.xyz + fog.xyz;
	o.w = prefogcolor_enhance.w;

	return o;
}