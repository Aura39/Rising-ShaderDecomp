sampler Color_1_sampler : register(s0);
sampler Shadow_Tex_sampler : register(s11);
float4 ambient_rate : register(c40);
float4 ambient_rate_rate : register(c71);
float3 fog : register(c67);
float4 g_All_Offset : register(c76);
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
sampler tripleMask_sampler : register(s1);

struct PS_IN
{
	float2 texcoord : TEXCOORD;
	float3 texcoord1 : TEXCOORD1;
	float4 texcoord2 : TEXCOORD2;
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
	float4 r7;
	float4 r8;
	float3 r9;
	r0.x = 1 / spot_angle.w;
	r0.yzw = spot_angle.xyz + -i.texcoord1.xyz;
	r1.x = dot(r0.yzw, r0.yzw);
	r1.x = 1 / sqrt(r1.x);
	r1.y = 1 / r1.x;
	r0.yzw = r0.yzw * r1.xxx;
	r0.y = dot(r0.yzw, lightpos.xyz);
	r0.y = r0.y + -spot_param.x;
	r0.x = r0.x * r1.y;
	r0.x = -r0.x + 1;
	r0.x = r0.x * 10;
	r1.y = 1;
	r0.z = r1.y + -spot_param.x;
	r0.z = 1 / r0.z;
	r0.z = r0.z * r0.y;
	r1.x = max(r0.y, 0);
	r0.y = 1 / spot_param.y;
	r0.y = r0.y * r0.z;
	r0.z = frac(-r1.x);
	r0.z = r0.z + r1.x;
	r1.xyz = i.texcoord3.xyz;
	r2.xyz = r1.yzx * i.texcoord2.zxy;
	r1.xyz = i.texcoord2.yzx * r1.zxy + -r2.xyz;
	r2.xy = tile.xy;
	r2.xy = i.texcoord.xy * r2.xy + g_All_Offset.xy;
	r2 = tex2D(normalmap_sampler, r2);
	r2.xyz = r2.xyz + -0.5;
	r1.xyz = r1.xyz * -r2.yyy;
	r0.w = r2.x * i.texcoord2.w;
	r1.xyz = r0.www * i.texcoord2.xyz + r1.xyz;
	r1.xyz = r2.zzz * i.texcoord3.xyz + r1.xyz;
	r2.xyz = normalize(r1.xyz);
	r0.w = dot(lightpos.xyz, r2.xyz);
	r1.x = r0.w;
	r0.z = r0.z * r1.x;
	r0.y = r0.y * r0.z;
	r0.x = r0.x * r0.y;
	r2.w = lerp(r0.x, r1.x, spot_param.z);
	r0.x = (-r2.w >= 0) ? 0 : 1;
	r0.y = dot(-i.texcoord1.xyz, -i.texcoord1.xyz);
	r0.y = 1 / sqrt(r0.y);
	r1.xyz = -i.texcoord1.xyz * r0.yyy + lightpos.xyz;
	r3.xyz = r0.yyy * -i.texcoord1.xyz;
	r4.xyz = normalize(r1.xyz);
	r0.y = dot(r4.xyz, r2.xyz);
	r0.z = (-r0.y >= 0) ? 0 : r0.x;
	r0.x = r2.w * r0.x;
	r1.xyz = r2.www * light_Color.xyz;
	r4.xyz = r0.xxx * light_Color.xyz;
	r1.w = pow(r0.y, specularParam.z);
	r0.x = r0.z * r1.w;
	r0.xyz = r0.xxx * r4.xyz;
	r4.xy = tile.xy * i.texcoord.xy;
	r4 = tex2D(tripleMask_sampler, r4);
	r0.xyz = r0.xyz * r4.zzz;
	r1.w = 1 / i.texcoord7.w;
	r4.xy = r1.ww * i.texcoord7.xy;
	r4.xy = r4.xy * float2(0.5, -0.5) + 0.5;
	r4.xy = r4.xy + g_TargetUvParam.xy;
	r5 = tex2D(Shadow_Tex_sampler, r4);
	r1.w = r5.z + g_ShadowUse.x;
	r5.xyz = point_lightpos1.xyz + -i.texcoord1.xyz;
	r2.w = dot(r5.xyz, r5.xyz);
	r2.w = 1 / sqrt(r2.w);
	r6.xyz = r5.xyz * r2.www + r3.xyz;
	r5.xyz = r2.www * r5.xyz;
	r2.w = 1 / r2.w;
	r2.w = -r2.w + point_lightpos1.w;
	r2.w = r2.w * point_light1.w;
	r3.w = dot(r5.xyz, r2.xyz);
	r5.xyz = normalize(r6.xyz);
	r4.x = dot(r5.xyz, r2.xyz);
	r4.y = (-r3.w >= 0) ? 0 : 1;
	r5.x = (-r4.x >= 0) ? 0 : r4.y;
	r5.y = pow(r4.x, specularParam.z);
	r4.x = r5.y * r5.x;
	r4.y = r3.w * r4.y;
	r5.xyz = r3.www * point_light1.xyz;
	r5.xyz = r2.www * r5.xyz;
	r6.xyz = r4.yyy * point_light1.xyz;
	r6.xyz = r4.xxx * r6.xyz;
	r6.xyz = r4.zzz * r6.xyz;
	r6.xyz = r2.www * r6.xyz;
	r7 = g_specCalc1;
	r6.xyz = r6.xyz * r7.xxx;
	r0.xyz = r0.xyz * r1.www + r6.xyz;
	r6.xyz = point_lightpos2.xyz + -i.texcoord1.xyz;
	r2.w = dot(r6.xyz, r6.xyz);
	r2.w = 1 / sqrt(r2.w);
	r8.xyz = r6.xyz * r2.www + r3.xyz;
	r6.xyz = r2.www * r6.xyz;
	r2.w = 1 / r2.w;
	r2.w = -r2.w + point_lightpos2.w;
	r2.w = r2.w * point_light2.w;
	r3.w = dot(r6.xyz, r2.xyz);
	r6.xyz = normalize(r8.xyz);
	r4.x = dot(r6.xyz, r2.xyz);
	r4.y = (-r3.w >= 0) ? 0 : 1;
	r5.w = (-r4.x >= 0) ? 0 : r4.y;
	r6.x = pow(r4.x, specularParam.z);
	r4.x = r5.w * r6.x;
	r4.y = r3.w * r4.y;
	r6.xyz = r3.www * point_light2.xyz;
	r6.xyz = r2.www * r6.xyz;
	r8.xyz = r4.yyy * point_light2.xyz;
	r8.xyz = r4.xxx * r8.xyz;
	r8.xyz = r4.zzz * r8.xyz;
	r8.xyz = r2.www * r8.xyz;
	r0.xyz = r8.xyz * r7.yyy + r0.xyz;
	r8.xyz = point_lightposEv0.xyz + -i.texcoord1.xyz;
	r2.w = dot(r8.xyz, r8.xyz);
	r2.w = 1 / sqrt(r2.w);
	r9.xyz = r8.xyz * r2.www + r3.xyz;
	r8.xyz = r2.www * r8.xyz;
	r2.w = 1 / r2.w;
	r2.w = -r2.w + point_lightposEv0.w;
	r2.w = r2.w * point_lightEv0.w;
	r3.w = dot(r8.xyz, r2.xyz);
	r8.xyz = normalize(r9.xyz);
	r4.x = dot(r8.xyz, r2.xyz);
	r4.y = (-r3.w >= 0) ? 0 : 1;
	r5.w = (-r4.x >= 0) ? 0 : r4.y;
	r6.w = pow(r4.x, specularParam.z);
	r4.x = r5.w * r6.w;
	r4.y = r3.w * r4.y;
	r8.xyz = r4.yyy * point_lightEv0.xyz;
	r8.xyz = r4.xxx * r8.xyz;
	r8.xyz = r4.zzz * r8.xyz;
	r8.xyz = r2.www * r8.xyz;
	r0.xyz = r8.xyz * r7.zzz + r0.xyz;
	r7.xyz = point_lightposEv1.xyz + -i.texcoord1.xyz;
	r4.x = dot(r7.xyz, r7.xyz);
	r4.x = 1 / sqrt(r4.x);
	r8.xyz = r7.xyz * r4.xxx + r3.xyz;
	r7.xyz = r4.xxx * r7.xyz;
	r4.x = 1 / r4.x;
	r4.x = -r4.x + point_lightposEv1.w;
	r4.x = r4.x * point_lightEv1.w;
	r4.y = dot(r7.xyz, r2.xyz);
	r7.xyz = normalize(r8.xyz);
	r5.w = dot(r7.xyz, r2.xyz);
	r6.w = (-r4.y >= 0) ? 0 : 1;
	r7.x = (-r5.w >= 0) ? 0 : r6.w;
	r7.y = pow(r5.w, specularParam.z);
	r5.w = r7.y * r7.x;
	r6.w = r4.y * r6.w;
	r7.xyz = r6.www * point_lightEv1.xyz;
	r7.xyz = r5.www * r7.xyz;
	r7.xyz = r4.zzz * r7.xyz;
	r7.xyz = r4.xxx * r7.xyz;
	r0.xyz = r7.xyz * r7.www + r0.xyz;
	r5.w = g_specCalc2.x;
	r7.xyz = point_lightposEv2.xyz + -i.texcoord1.xyz;
	r6.w = dot(r7.xyz, r7.xyz);
	r6.w = 1 / sqrt(r6.w);
	r3.xyz = r7.xyz * r6.www + r3.xyz;
	r7.xyz = r6.www * r7.xyz;
	r6.w = 1 / r6.w;
	r6.w = -r6.w + point_lightposEv2.w;
	r6.w = r6.w * point_lightEv2.w;
	r7.x = dot(r7.xyz, r2.xyz);
	r8.xyz = normalize(r3.xyz);
	r3.x = dot(r8.xyz, r2.xyz);
	r3.y = (-r7.x >= 0) ? 0 : 1;
	r3.z = (-r3.x >= 0) ? 0 : r3.y;
	r7.y = pow(r3.x, specularParam.z);
	r3.x = r3.z * r7.y;
	r3.y = r7.x * r3.y;
	r7.yzw = r3.yyy * point_lightEv2.xyz;
	r3.xyz = r3.xxx * r7.yzw;
	r3.xyz = r4.zzz * r3.xyz;
	r3.xyz = r6.www * r3.xyz;
	r0.xyz = r3.xyz * r5.www + r0.xyz;
	r3.x = abs(specularParam.x);
	r0.xyz = r0.xyz * r3.xxx;
	r3.xyz = muzzle_lightpos.xyz + -i.texcoord1.xyz;
	r4.z = dot(r3.xyz, r3.xyz);
	r4.z = 1 / sqrt(r4.z);
	r3.xyz = r3.xyz * r4.zzz;
	r4.z = 1 / r4.z;
	r4.z = -r4.z + muzzle_lightpos.w;
	r4.z = r4.z * muzzle_light.w;
	r2.x = dot(r3.xyz, r2.xyz);
	r2.xyz = r2.xxx * muzzle_light.xyz;
	r8 = g_specCalc1;
	r8 = -r8 + 2;
	r3.xyz = r5.xyz * r8.xxx;
	r2.xyz = r2.xyz * r4.zzz + r3.xyz;
	r2.xyz = r6.xyz * r8.yyy + r2.xyz;
	r1.xyz = r1.xyz * r1.www + r2.xyz;
	r1.w = -r1.w + 1;
	r2.xy = g_All_Offset.xy + i.texcoord.xy;
	r5 = tex2D(Color_1_sampler, r2);
	r2.xy = -r5.yy + r5.xz;
	r3.x = max(abs(r2.x), abs(r2.y));
	r2.x = r3.x + -0.015625;
	r2.y = (-r2.x >= 0) ? 0 : 1;
	r2.x = (r2.x >= 0) ? -0 : -1;
	r2.x = r2.x + r2.y;
	r2.x = (r2.x >= 0) ? -r2.x : -0;
	r5.xz = (r2.xx >= 0) ? r5.yy : r5.xz;
	r2.xyz = r5.xyz * point_lightEv0.xyz;
	r2.xyz = r3.www * r2.xyz;
	r2.xyz = r2.www * r2.xyz;
	r2.xyz = r8.zzz * r2.xyz;
	r1.xyz = r5.xyz * r1.xyz + r2.xyz;
	r2.xyz = r5.xyz * point_lightEv1.xyz;
	r2.xyz = r4.yyy * r2.xyz;
	r2.xyz = r4.xxx * r2.xyz;
	r1.xyz = r2.xyz * r8.www + r1.xyz;
	r2.xyz = r5.xyz * point_lightEv2.xyz;
	r2.xyz = r7.xxx * r2.xyz;
	r2.xyz = r6.www * r2.xyz;
	r3.x = 2;
	r2.w = r3.x + -g_specCalc2.x;
	r1.xyz = r2.xyz * r2.www + r1.xyz;
	r1.xyz = r4.www * r1.xyz;
	r2.x = dot(lightpos.xyz, i.texcoord3.xyz);
	r0.w = r0.w + -r2.x;
	r0.w = r0.w + 1;
	r2.xyz = r5.xyz * i.texcoord5.xyz;
	r2.xyz = r1.www * r2.xyz;
	r3.xyz = r5.xyz * ambient_rate.xyz;
	r4.xyz = r5.xyz + specularParam.www;
	r2.xyz = r3.xyz * ambient_rate_rate.xyz + r2.xyz;
	r1.xyz = r2.xyz * r0.www + r1.xyz;
	r0.xyz = r0.xyz * r4.xyz + r1.xyz;
	r1.xyz = fog.xyz;
	r0.xyz = r0.xyz * prefogcolor_enhance.xyz + -r1.xyz;
	o.xyz = i.texcoord8.www * r0.xyz + fog.xyz;
	o.w = prefogcolor_enhance.w;

	return o;
}
