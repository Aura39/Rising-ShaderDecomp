sampler Color_1_sampler;
sampler Shadow_Tex_sampler;
float4 ambient_rate;
float4 ambient_rate_rate;
float3 fog;
float4 g_All_Offset;
float4 g_NormalWeightParam;
float g_ShadowUse;
float4 g_TargetUvParam;
float4 g_WeightParam;
float4 g_specCalc1;
float4 g_specCalc2;
float4 light_Color;
float4 lightpos;
float4 muzzle_light;
float4 muzzle_lightpos;
sampler normalmap1_sampler;
sampler normalmap2_sampler;
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
sampler weightmap1_sampler;

struct PS_IN
{
	float4 texcoord : TEXCOORD;
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
	float3 r9;
	float3 r10;
	float3 r11;
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
	r1.xz = float2(2, -1);
	r0.w = r1.z + -spot_param.x;
	r0.w = 1 / r0.w;
	r0.w = r0.w * r0.z;
	r1.y = max(r0.z, 0);
	r0.z = 1 / spot_param.y;
	r0.z = r0.z * r0.w;
	r0.w = frac(-r1.y);
	r0.w = r0.w + r1.y;
	r1.yw = lerp(i.texcoord.zw, i.texcoord.xy, g_NormalWeightParam.zz);
	r2.xy = r1.yw * tile.xy;
	r1.yw = r1.yw + g_All_Offset.xy;
	r3 = tex2D(Color_1_sampler, r1.ywzw);
	r4 = tex2D(normalmap2_sampler, r2);
	r1.yw = lerp(r4.zw, r4.xy, g_NormalWeightParam.yy);
	r1.yw = r1.yw * 2 + -1;
	r4 = tex2D(weightmap1_sampler, r2);
	r2.z = dot(r4.xyz, g_WeightParam.xyz);
	r2.w = r2.z * g_NormalWeightParam.x;
	r2.z = g_NormalWeightParam.x * r2.z + r1.z;
	r2.z = 1 / r2.z;
	r4 = tex2D(normalmap1_sampler, r2);
	r5 = tex2D(tripleMask_sampler, r2);
	r2.xy = r4.xy * 2 + -1;
	r1.yw = r1.yw * r2.ww + r2.xy;
	r1.yw = r2.zz * r1.yw;
	r2.x = r1.y * i.texcoord2.w;
	r2.y = -r1.w;
	r1.y = dot(r2.y, r2.y) + 0;
	r1.y = -r1.y + 1;
	r1.y = 1 / sqrt(r1.y);
	r1.y = 1 / r1.y;
	r4.xyz = i.texcoord3.xyz;
	r6.xyz = r4.yzx * i.texcoord2.zxy;
	r4.xyz = i.texcoord2.yzx * r4.zxy + -r6.xyz;
	r2.yzw = r2.yyy * r4.xyz;
	r2.xyz = r2.xxx * i.texcoord2.xyz + r2.yzw;
	r2.xyz = r1.yyy * i.texcoord3.xyz + r2.xyz;
	r1.y = dot(r2.xyz, r2.xyz);
	r1.y = 1 / sqrt(r1.y);
	r2.xyw = r1.yyy * r2.xyz;
	r1.y = r2.z * -r1.y + 1;
	r1.w = dot(lightpos.xyz, r2.xyw);
	r2.z = r1.w;
	r0.w = r0.w * r2.z;
	r0.z = r0.z * r0.w;
	r0.y = r0.y * r0.z;
	r3.w = lerp(r0.y, r2.z, spot_param.z);
	r0.y = (-r3.w >= 0) ? 0 : 1;
	r0.z = dot(-i.texcoord1.xyz, -i.texcoord1.xyz);
	r0.z = 1 / sqrt(r0.z);
	r4.xyz = -i.texcoord1.xyz * r0.zzz + lightpos.xyz;
	r6.xyz = r0.zzz * -i.texcoord1.xyz;
	r7.xyz = normalize(r4.xyz);
	r0.z = dot(r7.xyz, r2.xyw);
	r0.w = (-r0.z >= 0) ? 0 : r0.y;
	r0.y = r3.w * r0.y;
	r4.xyz = r0.yyy * light_Color.xyz;
	r2.z = pow(r0.z, specularParam.z);
	r0.y = r0.w * r2.z;
	r0.yzw = r0.yyy * r4.xyz;
	r0.yzw = r5.zzz * r0.yzw;
	r4.xyz = point_lightpos1.xyz + -i.texcoord1.xyz;
	r2.z = dot(r4.xyz, r4.xyz);
	r2.z = 1 / sqrt(r2.z);
	r7.xyz = r4.xyz * r2.zzz + r6.xyz;
	r4.xyz = r2.zzz * r4.xyz;
	r2.z = 1 / r2.z;
	r2.z = -r2.z + point_lightpos1.w;
	r2.z = r2.z * point_light1.w;
	r4.x = dot(r4.xyz, r2.xyw);
	r8.xyz = normalize(r7.xyz);
	r4.y = dot(r8.xyz, r2.xyw);
	r4.z = (-r4.x >= 0) ? 0 : 1;
	r4.w = (-r4.y >= 0) ? 0 : r4.z;
	r5.y = pow(r4.y, specularParam.z);
	r4.y = r4.w * r5.y;
	r4.z = r4.x * r4.z;
	r7.xyz = r4.xxx * point_light1.xyz;
	r7.xyz = r2.zzz * r7.xyz;
	r4.xzw = r4.zzz * point_light1.xyz;
	r4.xyz = r4.yyy * r4.xzw;
	r4.xyz = r5.zzz * r4.xyz;
	r4.xyz = r2.zzz * r4.xyz;
	r8 = g_specCalc1;
	r4.xyz = r4.xyz * r8.xxx;
	r0.yzw = r0.yzw * r0.xxx + r4.xyz;
	r4.xyz = point_lightpos2.xyz + -i.texcoord1.xyz;
	r2.z = dot(r4.xyz, r4.xyz);
	r2.z = 1 / sqrt(r2.z);
	r9.xyz = r4.xyz * r2.zzz + r6.xyz;
	r4.xyz = r2.zzz * r4.xyz;
	r2.z = 1 / r2.z;
	r2.z = -r2.z + point_lightpos2.w;
	r2.z = r2.z * point_light2.w;
	r4.x = dot(r4.xyz, r2.xyw);
	r10.xyz = normalize(r9.xyz);
	r4.y = dot(r10.xyz, r2.xyw);
	r4.z = (-r4.x >= 0) ? 0 : 1;
	r4.w = (-r4.y >= 0) ? 0 : r4.z;
	r5.y = pow(r4.y, specularParam.z);
	r4.y = r4.w * r5.y;
	r4.z = r4.x * r4.z;
	r9.xyz = r4.xxx * point_light2.xyz;
	r9.xyz = r2.zzz * r9.xyz;
	r4.xzw = r4.zzz * point_light2.xyz;
	r4.xyz = r4.yyy * r4.xzw;
	r4.xyz = r5.zzz * r4.xyz;
	r4.xyz = r2.zzz * r4.xyz;
	r0.yzw = r4.xyz * r8.yyy + r0.yzw;
	r4.xyz = point_lightposEv0.xyz + -i.texcoord1.xyz;
	r2.z = dot(r4.xyz, r4.xyz);
	r2.z = 1 / sqrt(r2.z);
	r10.xyz = r4.xyz * r2.zzz + r6.xyz;
	r4.xyz = r2.zzz * r4.xyz;
	r2.z = 1 / r2.z;
	r2.z = -r2.z + point_lightposEv0.w;
	r2.z = r2.z * point_lightEv0.w;
	r4.x = dot(r4.xyz, r2.xyw);
	r11.xyz = normalize(r10.xyz);
	r4.y = dot(r11.xyz, r2.xyw);
	r4.z = (-r4.x >= 0) ? 0 : 1;
	r4.w = (-r4.y >= 0) ? 0 : r4.z;
	r5.y = pow(r4.y, specularParam.z);
	r4.y = r4.w * r5.y;
	r4.z = r4.x * r4.z;
	r10.xyz = r4.zzz * point_lightEv0.xyz;
	r4.yzw = r4.yyy * r10.xyz;
	r4.yzw = r5.zzz * r4.yzw;
	r4.yzw = r2.zzz * r4.yzw;
	r0.yzw = r4.yzw * r8.zzz + r0.yzw;
	r4.yzw = point_lightposEv1.xyz + -i.texcoord1.xyz;
	r5.y = dot(r4.yzw, r4.yzw);
	r5.y = 1 / sqrt(r5.y);
	r8.xyz = r4.yzw * r5.yyy + r6.xyz;
	r4.yzw = r4.yzw * r5.yyy;
	r5.y = 1 / r5.y;
	r5.y = -r5.y + point_lightposEv1.w;
	r5.y = r5.y * point_lightEv1.w;
	r4.y = dot(r4.yzw, r2.xyw);
	r10.xyz = normalize(r8.xyz);
	r4.z = dot(r10.xyz, r2.xyw);
	r4.w = (-r4.y >= 0) ? 0 : 1;
	r6.w = (-r4.z >= 0) ? 0 : r4.w;
	r7.w = pow(r4.z, specularParam.z);
	r4.z = r6.w * r7.w;
	r4.w = r4.y * r4.w;
	r8.xyz = r4.www * point_lightEv1.xyz;
	r8.xyz = r4.zzz * r8.xyz;
	r8.xyz = r5.zzz * r8.xyz;
	r8.xyz = r5.yyy * r8.xyz;
	r0.yzw = r8.xyz * r8.www + r0.yzw;
	r4.z = g_specCalc2.x;
	r8.xyz = point_lightposEv2.xyz + -i.texcoord1.xyz;
	r4.w = dot(r8.xyz, r8.xyz);
	r4.w = 1 / sqrt(r4.w);
	r6.xyz = r8.xyz * r4.www + r6.xyz;
	r8.xyz = r4.www * r8.xyz;
	r4.w = 1 / r4.w;
	r4.w = -r4.w + point_lightposEv2.w;
	r4.w = r4.w * point_lightEv2.w;
	r6.w = dot(r8.xyz, r2.xyw);
	r8.xyz = normalize(r6.xyz);
	r6.x = dot(r8.xyz, r2.xyw);
	r6.y = (-r6.w >= 0) ? 0 : 1;
	r6.z = (-r6.x >= 0) ? 0 : r6.y;
	r7.w = pow(r6.x, specularParam.z);
	r6.x = r6.z * r7.w;
	r6.y = r6.w * r6.y;
	r8.xyz = r6.yyy * point_lightEv2.xyz;
	r6.xyz = r6.xxx * r8.xyz;
	r6.xyz = r5.zzz * r6.xyz;
	r6.xyz = r4.www * r6.xyz;
	r0.yzw = r6.xyz * r4.zzz + r0.yzw;
	r4.z = r3.w + -0.5;
	r6.xyz = r3.www * light_Color.xyz;
	r3.w = r4.z + r5.x;
	r0.yzw = r0.yzw * r3.www;
	r4.z = abs(specularParam.x);
	r0.yzw = r0.yzw * r4.zzz;
	r8.xyz = muzzle_lightpos.xyz + -i.texcoord1.xyz;
	r4.z = dot(r8.xyz, r8.xyz);
	r4.z = 1 / sqrt(r4.z);
	r8.xyz = r4.zzz * r8.xyz;
	r4.z = 1 / r4.z;
	r4.z = -r4.z + muzzle_lightpos.w;
	r4.z = r4.z * muzzle_light.w;
	r2.x = dot(r8.xyz, r2.xyw);
	r2.xyw = r2.xxx * muzzle_light.xyz;
	r8 = r1.x + -g_specCalc1;
	r7.xyz = r7.xyz * r8.xxx;
	r2.xyw = r2.xyw * r4.zzz + r7.xyz;
	r2.xyw = r9.xyz * r8.yyy + r2.xyw;
	r2.xyw = r6.xyz * r0.xxx + r2.xyw;
	r6.xy = -r3.yy + r3.xz;
	r0.x = max(abs(r6.x), abs(r6.y));
	r0.x = r0.x + -0.015625;
	r4.z = (-r0.x >= 0) ? 0 : 1;
	r0.x = (r0.x >= 0) ? -0 : -1;
	r0.x = r0.x + r4.z;
	r0.x = (r0.x >= 0) ? -r0.x : -0;
	r3.xz = (r0.xx >= 0) ? r3.yy : r3.xz;
	r6.xyz = r3.www * r3.xyz;
	r7.xyz = r6.xyz * point_lightEv0.xyz;
	r7.xyz = r4.xxx * r7.xyz;
	r7.xyz = r2.zzz * r7.xyz;
	r7.xyz = r8.zzz * r7.xyz;
	r2.xyz = r6.xyz * r2.xyw + r7.xyz;
	r7.xyz = r6.xyz * point_lightEv1.xyz;
	r6.xyz = r6.xyz * point_lightEv2.xyz;
	r6.xyz = r6.www * r6.xyz;
	r4.xzw = r4.www * r6.xyz;
	r6.xyz = r4.yyy * r7.xyz;
	r6.xyz = r5.yyy * r6.xyz;
	r2.xyz = r6.xyz * r8.www + r2.xyz;
	r0.x = r1.x + -g_specCalc2.x;
	r2.xyz = r4.xzw * r0.xxx + r2.xyz;
	r2.xyz = r5.www * r2.xyz;
	r4.xyz = r5.xxx * r3.xyz;
	r3.xyz = r3.xyz + specularParam.www;
	r0.x = dot(lightpos.xyz, i.texcoord3.xyz);
	r0.x = -r0.x + r1.w;
	r0.x = r0.x + 1;
	r5.xyz = r4.xyz * ambient_rate.xyz;
	r4.xyz = r1.yyy * r4.xyz;
	r1.x = r1.y + -ss_scat_rate.x;
	r4.xyz = r4.xyz * ss_scat_pow.xxx;
	r5.xyz = r5.xyz * ambient_rate_rate.xyz;
	r2.xyz = r5.xyz * r0.xxx + r2.xyz;
	r0.xyz = r0.yzw * r3.xyz + r2.xyz;
	r0.w = r1.z + -ss_scat_rate.x;
	r0.w = 1 / r0.w;
	r0.w = r0.w * r1.x;
	r1.x = r1.x;
	r1.y = frac(-r1.x);
	r1.x = r1.y + r1.x;
	r0.w = r0.w * r1.x;
	r0.xyz = r4.xyz * r0.www + r0.xyz;
	r1.xyz = fog.xyz;
	r0.xyz = r0.xyz * prefogcolor_enhance.xyz + -r1.xyz;
	o.xyz = i.texcoord1.www * r0.xyz + fog.xyz;
	o.w = prefogcolor_enhance.w;

	return o;
}