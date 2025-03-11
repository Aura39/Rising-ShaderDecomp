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
	r2.yzw = r2.yzw * r3.xxx;
	r3.x = -r3.y + point_lightpos1.w;
	r3.x = r3.x * point_light1.w;
	r4.xyz = i.texcoord3.xyz;
	r3.yzw = r4.yzx * i.texcoord2.zxy;
	r3.yzw = i.texcoord2.yzx * r4.zxy + -r3.yzw;
	r4.xy = g_All_Offset.xy;
	r4.xy = i.texcoord.xy * tile.xy + r4.xy;
	r4 = tex2D(normalmap_sampler, r4);
	r4.xyz = r4.xyz + -0.5;
	r3.yzw = r3.yzw * -r4.yyy;
	r4.x = r4.x * i.texcoord2.w;
	r3.yzw = r4.xxx * i.texcoord2.xyz + r3.yzw;
	r3.yzw = r4.zzz * i.texcoord3.xyz + r3.yzw;
	r4.xyz = normalize(r3.yzw);
	r2.y = dot(r2.yzw, r4.xyz);
	r2.yzw = r2.yyy * point_light1.xyz;
	r2.yzw = r3.xxx * r2.yzw;
	r3.y = 2;
	r5 = r3.y + -g_specCalc1;
	r2.yzw = r2.yzw * r5.xxx;
	r1.y = dot(r1.yzw, r4.xyz);
	r1.yzw = r1.yyy * muzzle_light.xyz;
	r1.yzw = r1.yzw * r2.xxx + r2.yzw;
	r2.xyz = point_lightpos2.xyz + -i.texcoord1.xyz;
	r2.w = dot(r2.xyz, r2.xyz);
	r2.w = 1 / sqrt(r2.w);
	r3.x = 1 / r2.w;
	r2.xyz = r2.www * r2.xyz;
	r2.x = dot(r2.xyz, r4.xyz);
	r2.xyz = r2.xxx * point_light2.xyz;
	r2.w = -r3.x + point_lightpos2.w;
	r2.w = r2.w * point_light2.w;
	r2.xyz = r2.www * r2.xyz;
	r1.yzw = r2.xyz * r5.yyy + r1.yzw;
	r2.x = 1 / spot_angle.w;
	r2.yzw = spot_angle.xyz + -i.texcoord1.xyz;
	r3.x = dot(r2.yzw, r2.yzw);
	r3.x = 1 / sqrt(r3.x);
	r3.z = 1 / r3.x;
	r2.yzw = r2.yzw * r3.xxx;
	r2.y = dot(r2.yzw, lightpos.xyz);
	r2.x = r2.x * r3.z;
	r2.x = -r2.x + 1;
	r2.x = r2.x * 10;
	r2.z = 1;
	r2.yw = r2.yz + -spot_param.xx;
	r2.w = 1 / r2.w;
	r2.w = r2.w * r2.y;
	r3.x = max(r2.y, 0);
	r2.y = 1 / spot_param.y;
	r2.y = r2.y * r2.w;
	r2.w = frac(-r3.x);
	r2.w = r2.w + r3.x;
	r3.x = dot(lightpos.xyz, r4.xyz);
	r3.z = r3.x;
	r2.w = r2.w * r3.z;
	r2.y = r2.y * r2.w;
	r2.x = r2.x * r2.y;
	r5.x = lerp(r2.x, r3.z, spot_param.z);
	r2.xyw = r5.xxx * light_Color.xyz;
	r3.z = r5.x * 0.5 + 0.5;
	r1.yzw = r2.xyw * r1.xxx + r1.yzw;
	r1.x = -r1.x + 1;
	r2.xy = -r0.yy + r0.xz;
	r3.w = max(abs(r2.x), abs(r2.y));
	r2.x = r3.w + -0.015625;
	r2.y = (-r2.x >= 0) ? 0 : 1;
	r2.x = (r2.x >= 0) ? -0 : -1;
	r2.x = r2.x + r2.y;
	r2.x = (r2.x >= 0) ? -r2.x : -0;
	r0.xz = (r2.xx >= 0) ? r0.yy : r0.xz;
	r2.xyw = point_lightposEv0.xyz + -i.texcoord1.xyz;
	r3.w = dot(r2.xyw, r2.xyw);
	r3.w = 1 / sqrt(r3.w);
	r5.x = 1 / r3.w;
	r2.xyw = r2.xyw * r3.www;
	r2.x = dot(r2.xyw, r4.xyz);
	r2.y = -r5.x + point_lightposEv0.w;
	r2.y = r2.y * point_lightEv0.w;
	r0.w = r0.w * prefogcolor_enhance.w;
	o.w = r0.w;
	r6.xyz = r0.xyz * point_lightEv0.xyz;
	r6.xyz = r2.xxx * r6.xyz;
	r2.xyw = r2.yyy * r6.xyz;
	r2.xyw = r5.zzz * r2.xyw;
	r1.yzw = r0.xyz * r1.yzw + r2.xyw;
	r2.xyw = point_lightposEv1.xyz + -i.texcoord1.xyz;
	r0.w = dot(r2.xyw, r2.xyw);
	r0.w = 1 / sqrt(r0.w);
	r2.xyw = r0.www * r2.xyw;
	r0.w = 1 / r0.w;
	r0.w = -r0.w + point_lightposEv1.w;
	r0.w = r0.w * point_lightEv1.w;
	r2.x = dot(r2.xyw, r4.xyz);
	r5.xyz = r0.xyz * point_lightEv1.xyz;
	r2.xyw = r2.xxx * r5.xyz;
	r2.xyw = r0.www * r2.xyw;
	r1.yzw = r2.xyw * r5.www + r1.yzw;
	r0.w = r3.y + -g_specCalc2.x;
	r2.xyw = point_lightposEv2.xyz + -i.texcoord1.xyz;
	r3.y = dot(r2.xyw, r2.xyw);
	r3.y = 1 / sqrt(r3.y);
	r2.xyw = r2.xyw * r3.yyy;
	r3.y = 1 / r3.y;
	r3.y = -r3.y + point_lightposEv2.w;
	r3.y = r3.y * point_lightEv2.w;
	r2.x = dot(r2.xyw, r4.xyz);
	r5.xyz = r0.xyz * point_lightEv2.xyz;
	r2.xyw = r2.xxx * r5.xyz;
	r2.xyw = r3.yyy * r2.xyw;
	r1.yzw = r2.xyw * r0.www + r1.yzw;
	r2.xyw = r0.xyz * i.texcoord5.xyz;
	r2.xyw = r1.xxx * r2.xyw;
	r5.xyz = r0.xyz * ambient_rate.xyz;
	r2.xyw = r5.xyz * ambient_rate_rate.xyz + r2.xyw;
	r0.w = dot(lightpos.xyz, i.texcoord3.xyz);
	r0.w = -r0.w + r3.x;
	r0.w = r0.w + 1;
	r1.xyz = r2.xyw * r0.www + r1.yzw;
	r5.x = dot(r4.xyz, transpose(viewInverseMatrix)[0].xyz);
	r5.y = dot(r4.xyz, transpose(viewInverseMatrix)[1].xyz);
	r5.z = dot(r4.xyz, transpose(viewInverseMatrix)[2].xyz);
	r0.w = dot(i.texcoord4.xyz, r5.xyz);
	r0.w = r0.w + r0.w;
	r5.xyz = r5.xyz * -r0.www + i.texcoord4.xyz;
	r5.w = -r5.z;
	r6 = tex2D(cubemap_sampler, r5.xyww);
	r5 = tex2D(cubemap2_sampler, r5.xyww);
	r7 = lerp(r5, r6, g_CubeBlendParam.x);
	r5 = r7 * ambient_rate_rate.w;
	r5.xyz = r4.www * r5.xyz;
	r3 = r3.z * r5;
	r0.w = r3.w * CubeParam.y + CubeParam.x;
	r2.xyw = r0.www * r3.xyz;
	r0.xyz = r0.xyz * r2.xyw;
	r3.xyz = r0.xyz * CubeParam.zzz + r1.xyz;
	r0.xyz = r0.xyz * CubeParam.zzz;
	r0.xyz = r1.xyz * -r0.xyz + r3.xyz;
	r0.w = r2.z + -CubeParam.z;
	r0.xyz = r2.xyw * r0.www + r0.xyz;
	r1.xyz = fog.xyz;
	r0.xyz = r0.xyz * prefogcolor_enhance.xyz + -r1.xyz;
	o.xyz = i.texcoord8.www * r0.xyz + fog.xyz;

	return o;
}
