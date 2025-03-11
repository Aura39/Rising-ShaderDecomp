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
	r0.y = 1;
	r0.x = r0.y + -spot_param.x;
	r0.x = 1 / r0.x;
	r0.yzw = spot_angle.xyz + -i.texcoord1.xyz;
	r1.x = dot(r0.yzw, r0.yzw);
	r1.x = 1 / sqrt(r1.x);
	r0.yzw = r0.yzw * r1.xxx;
	r1.x = 1 / r1.x;
	r0.y = dot(r0.yzw, lightpos.xyz);
	r0.y = r0.y + -spot_param.x;
	r0.x = r0.x * r0.y;
	r1.y = max(r0.y, 0);
	r0.y = 1 / spot_param.y;
	r0.x = r0.y * r0.x;
	r0.y = frac(-r1.y);
	r0.y = r0.y + r1.y;
	r0.z = dot(lightpos.xyz, i.texcoord3.xyz);
	r0.y = r0.y * r0.z;
	r0.x = r0.x * r0.y;
	r0.y = 1 / spot_angle.w;
	r0.y = r0.y * r1.x;
	r0.y = -r0.y + 1;
	r0.y = r0.y * 10;
	r0.x = r0.y * r0.x;
	r1.x = lerp(r0.x, r0.z, spot_param.z);
	r0.x = (-r1.x >= 0) ? 0 : 1;
	r0.y = r1.x * r0.x;
	r1.xyz = r1.xxx * light_Color.xyz;
	r0.yzw = r0.yyy * light_Color.xyz;
	r1.w = dot(-i.texcoord1.xyz, -i.texcoord1.xyz);
	r1.w = 1 / sqrt(r1.w);
	r2.xyz = -i.texcoord1.xyz * r1.www + lightpos.xyz;
	r3.xyz = r1.www * -i.texcoord1.xyz;
	r4.xyz = normalize(r2.xyz);
	r1.w = dot(r4.xyz, i.texcoord3.xyz);
	r0.x = (-r1.w >= 0) ? 0 : r0.x;
	r2.x = pow(r1.w, specularParam.z);
	r0.x = r0.x * r2.x;
	r0.xyz = r0.xxx * r0.yzw;
	r2.xy = g_All_Offset.xy + i.texcoord.xy;
	r2 = tex2D(Color_1_sampler, r2);
	r0.xyz = r0.xyz * r2.www;
	r0.w = 1 / i.texcoord7.w;
	r4.xy = r0.ww * i.texcoord7.xy;
	r4.xy = r4.xy * float2(0.5, -0.5) + 0.5;
	r4.xy = r4.xy + g_TargetUvParam.xy;
	r4 = tex2D(Shadow_Tex_sampler, r4);
	r0.w = r4.z + g_ShadowUse.x;
	r4.xyz = point_lightpos1.xyz + -i.texcoord1.xyz;
	r1.w = dot(r4.xyz, r4.xyz);
	r1.w = 1 / sqrt(r1.w);
	r5.xyz = r4.xyz * r1.www + r3.xyz;
	r4.xyz = r1.www * r4.xyz;
	r1.w = 1 / r1.w;
	r1.w = -r1.w + point_lightpos1.w;
	r1.w = r1.w * point_light1.w;
	r3.w = dot(r4.xyz, i.texcoord3.xyz);
	r4.xyz = normalize(r5.xyz);
	r4.x = dot(r4.xyz, i.texcoord3.xyz);
	r4.y = (-r3.w >= 0) ? 0 : 1;
	r4.z = (-r4.x >= 0) ? 0 : r4.y;
	r5.x = pow(r4.x, specularParam.z);
	r4.x = r4.z * r5.x;
	r4.y = r3.w * r4.y;
	r5.xyz = r3.www * point_light1.xyz;
	r5.xyz = r1.www * r5.xyz;
	r4.yzw = r4.yyy * point_light1.xyz;
	r4.xyz = r4.xxx * r4.yzw;
	r4.xyz = r2.www * r4.xyz;
	r4.xyz = r1.www * r4.xyz;
	r6 = g_specCalc1;
	r4.xyz = r4.xyz * r6.xxx;
	r0.xyz = r0.xyz * r0.www + r4.xyz;
	r4.xyz = point_lightpos2.xyz + -i.texcoord1.xyz;
	r1.w = dot(r4.xyz, r4.xyz);
	r1.w = 1 / sqrt(r1.w);
	r7.xyz = r4.xyz * r1.www + r3.xyz;
	r4.xyz = r1.www * r4.xyz;
	r1.w = 1 / r1.w;
	r1.w = -r1.w + point_lightpos2.w;
	r1.w = r1.w * point_light2.w;
	r3.w = dot(r4.xyz, i.texcoord3.xyz);
	r4.xyz = normalize(r7.xyz);
	r4.x = dot(r4.xyz, i.texcoord3.xyz);
	r4.y = (-r3.w >= 0) ? 0 : 1;
	r4.z = (-r4.x >= 0) ? 0 : r4.y;
	r5.w = pow(r4.x, specularParam.z);
	r4.x = r4.z * r5.w;
	r4.y = r3.w * r4.y;
	r7.xyz = r3.www * point_light2.xyz;
	r7.xyz = r1.www * r7.xyz;
	r4.yzw = r4.yyy * point_light2.xyz;
	r4.xyz = r4.xxx * r4.yzw;
	r4.xyz = r2.www * r4.xyz;
	r4.xyz = r1.www * r4.xyz;
	r0.xyz = r4.xyz * r6.yyy + r0.xyz;
	r4.xyz = point_lightposEv0.xyz + -i.texcoord1.xyz;
	r1.w = dot(r4.xyz, r4.xyz);
	r1.w = 1 / sqrt(r1.w);
	r8.xyz = r4.xyz * r1.www + r3.xyz;
	r4.xyz = r1.www * r4.xyz;
	r1.w = 1 / r1.w;
	r1.w = -r1.w + point_lightposEv0.w;
	r1.w = r1.w * point_lightEv0.w;
	r3.w = dot(r4.xyz, i.texcoord3.xyz);
	r4.xyz = normalize(r8.xyz);
	r4.x = dot(r4.xyz, i.texcoord3.xyz);
	r4.y = (-r3.w >= 0) ? 0 : 1;
	r4.z = (-r4.x >= 0) ? 0 : r4.y;
	r5.w = pow(r4.x, specularParam.z);
	r4.x = r4.z * r5.w;
	r4.y = r3.w * r4.y;
	r4.yzw = r4.yyy * point_lightEv0.xyz;
	r4.xyz = r4.xxx * r4.yzw;
	r4.xyz = r2.www * r4.xyz;
	r4.xyz = r1.www * r4.xyz;
	r0.xyz = r4.xyz * r6.zzz + r0.xyz;
	r4.xyz = point_lightposEv1.xyz + -i.texcoord1.xyz;
	r4.w = dot(r4.xyz, r4.xyz);
	r4.w = 1 / sqrt(r4.w);
	r6.xyz = r4.xyz * r4.www + r3.xyz;
	r4.xyz = r4.www * r4.xyz;
	r4.w = 1 / r4.w;
	r4.w = -r4.w + point_lightposEv1.w;
	r4.w = r4.w * point_lightEv1.w;
	r4.x = dot(r4.xyz, i.texcoord3.xyz);
	r8.xyz = normalize(r6.xyz);
	r4.y = dot(r8.xyz, i.texcoord3.xyz);
	r4.z = (-r4.x >= 0) ? 0 : 1;
	r5.w = (-r4.y >= 0) ? 0 : r4.z;
	r6.x = pow(r4.y, specularParam.z);
	r4.y = r5.w * r6.x;
	r4.z = r4.x * r4.z;
	r6.xyz = r4.zzz * point_lightEv1.xyz;
	r6.xyz = r4.yyy * r6.xyz;
	r6.xyz = r2.www * r6.xyz;
	r6.xyz = r4.www * r6.xyz;
	r0.xyz = r6.xyz * r6.www + r0.xyz;
	r4.y = g_specCalc2.x;
	r6.xyz = point_lightposEv2.xyz + -i.texcoord1.xyz;
	r4.z = dot(r6.xyz, r6.xyz);
	r4.z = 1 / sqrt(r4.z);
	r3.xyz = r6.xyz * r4.zzz + r3.xyz;
	r6.xyz = r4.zzz * r6.xyz;
	r4.z = 1 / r4.z;
	r4.z = -r4.z + point_lightposEv2.w;
	r4.z = r4.z * point_lightEv2.w;
	r5.w = dot(r6.xyz, i.texcoord3.xyz);
	r6.xyz = normalize(r3.xyz);
	r3.x = dot(r6.xyz, i.texcoord3.xyz);
	r3.y = (-r5.w >= 0) ? 0 : 1;
	r3.z = (-r3.x >= 0) ? 0 : r3.y;
	r6.x = pow(r3.x, specularParam.z);
	r3.x = r3.z * r6.x;
	r3.y = r5.w * r3.y;
	r6.xyz = r3.yyy * point_lightEv2.xyz;
	r3.xyz = r3.xxx * r6.xyz;
	r3.xyz = r2.www * r3.xyz;
	r3.xyz = r4.zzz * r3.xyz;
	r0.xyz = r3.xyz * r4.yyy + r0.xyz;
	r2.w = abs(specularParam.x);
	r0.xyz = r0.xyz * r2.www;
	r6 = g_specCalc1;
	r6 = -r6 + 2;
	r3.xyz = r5.xyz * r6.xxx;
	r5.xyz = muzzle_lightpos.xyz + -i.texcoord1.xyz;
	r2.w = dot(r5.xyz, r5.xyz);
	r2.w = 1 / sqrt(r2.w);
	r5.xyz = r2.www * r5.xyz;
	r2.w = 1 / r2.w;
	r2.w = -r2.w + muzzle_lightpos.w;
	r2.w = r2.w * muzzle_light.w;
	r4.y = dot(r5.xyz, i.texcoord3.xyz);
	r5.xyz = r4.yyy * muzzle_light.xyz;
	r3.xyz = r5.xyz * r2.www + r3.xyz;
	r3.xyz = r7.xyz * r6.yyy + r3.xyz;
	r1.xyz = r1.xyz * r0.www + r3.xyz;
	r0.w = -r0.w + 1;
	r3.xy = -r2.yy + r2.xz;
	r2.w = max(abs(r3.x), abs(r3.y));
	r2.w = r2.w + -0.015625;
	r3.x = (-r2.w >= 0) ? 0 : 1;
	r2.w = (r2.w >= 0) ? -0 : -1;
	r2.w = r2.w + r3.x;
	r2.w = (r2.w >= 0) ? -r2.w : -0;
	r2.xz = (r2.ww >= 0) ? r2.yy : r2.xz;
	r3.xyz = r2.xyz * point_lightEv0.xyz;
	r3.xyz = r3.www * r3.xyz;
	r3.xyz = r1.www * r3.xyz;
	r3.xyz = r6.zzz * r3.xyz;
	r1.xyz = r2.xyz * r1.xyz + r3.xyz;
	r3.xyz = r2.xyz * point_lightEv1.xyz;
	r3.xyz = r4.xxx * r3.xyz;
	r3.xyz = r4.www * r3.xyz;
	r1.xyz = r3.xyz * r6.www + r1.xyz;
	r3.xyz = r2.xyz * point_lightEv2.xyz;
	r3.xyz = r5.www * r3.xyz;
	r3.xyz = r4.zzz * r3.xyz;
	r4.x = 2;
	r1.w = r4.x + -g_specCalc2.x;
	r1.xyz = r3.xyz * r1.www + r1.xyz;
	r3.xyz = r2.xyz * i.texcoord5.xyz;
	r3.xyz = r0.www * r3.xyz;
	r4.xyz = r2.xyz * ambient_rate.xyz;
	r2.xyz = r2.xyz + specularParam.www;
	r3.xyz = r4.xyz * ambient_rate_rate.xyz + r3.xyz;
	r1.xyz = r1.xyz + r3.xyz;
	r0.xyz = r0.xyz * r2.xyz + r1.xyz;
	r1.xyz = fog.xyz;
	r0.xyz = r0.xyz * prefogcolor_enhance.xyz + -r1.xyz;
	o.xyz = i.texcoord8.www * r0.xyz + fog.xyz;
	o.w = prefogcolor_enhance.w;

	return o;
}
